{ pkgs, self', ... }:
let
  inherit (pkgs.lib) pipe mapAttrs;

  /**
    Wrapper around writeShellApplication that also sets description and mainProgram.
  */
  mkProgram =
    {
      description,
      name,
      text,
      runtimeInputs ? [ ],
      ...
    }:
    (pkgs.writeShellApplication {
      inherit name runtimeInputs;
      text =
        # Silence pushd/popd for all scripts
        ''
          pushd () {
            command pushd "$@" > /dev/null
          }

          popd () {
            # popd is not passing arguments
            command popd > /dev/null
          }
        ''
        + text;
    }).overrideAttrs
      {
        meta = {
          # Description is used for devshell commands
          inherit description;
          # mainProgram is needed, otherwise calls to getExe emit a warning
          mainProgram = name;
        };
      };
    };

  /**
    The pipeline to import a file, apply whatever arguments are needed to generate the scripts and ultimately apply mkProgram to properly generate derivations.
  */
  importPipeline =
    file: applicationFunction:
    pipe file [
      builtins.import
      applicationFunction
      (mapAttrs (k: v: mkProgram (v // { name = k; })))
    ];
in
{
  # Deployment models
  localStreamlit = importPipeline ./local-streamlit (x: x { inherit pkgs; });
  sis = importPipeline ./sis (
    x:
    x {
      inherit pkgs;
      inherit (self'.packages) snowcli;
    }
  );
  localDocker = importPipeline ./local-docker (x: x { inherit pkgs; });

  # nativeAppApps = import ./native-app { };
  # gitApps = import ./git { };
  # sprocApps = import ./sprocs { };

  # docApps = import ./doc { };
}
