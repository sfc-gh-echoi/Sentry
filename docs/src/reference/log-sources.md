<!-- markdownlint-disable MD033 -->

# Log Sources for Security Monitoring

Customers can monitor their Snowflake deployment for potential indicators of
compromise by integrating Snowflake log sources with their Security Information
and Event Monitoring (SIEM) solution. This guide documents the security
identifiers and the Information Schema and Account Usage columns that Snowflake
recommends customers monitor. In addition, this publication maps columns to the
MITRE ATT&CK SaaS Matrix, an industry framework that helps security analysts
implement detection and response controls that align to their organization's
incident response procedures.

## Security Identifiers and Views

<!-- This rule is incompatible with tables -->
<!-- markdownlint-disable MD013 -->
| Security Identifier/View | Columns | Schema Location | Latency | MITRE ATT&CK |
|---|---|---|---|---|
| `APPLICABLE_ROLES` | `GRANTEE`<br>`ROLE_NAME`<br>`ROLE_OWNER`<br>`IS_GRANTABLE` | `INFORMATION_SCHEMA` | n/a | <a href="https://attack.mitre.org/techniques/T1060/" target="_blank">T1060- Permission Group Discovery</a><br><a href="https://attack.mitre.org/techniques/T1087/" target="_blank">T1087 - Account Discovery</a> |
| `STAGES` | `STAGE_NAME`<br>`CREATED`<br>`LAST_ALTERED` | `INFORMATION_SCHEMA` | n/a | <a href="https://attack.mitre.org/techniques/T1213/" target="_blank">T1213- Data Collection/ Exfiltration</a><br><a href="https://attack.mitre.org/techniques/T1074/" target="_blank">T1074 Data Staged</a> |
| `USAGE_PRIVILEGES` | `GRANTOR`<br>`GRANTEE`<br>`PRIVILEGE_TYPE`<br>`IS_GRANTABLE`<br>`CREATED` | `INFORMATION_SCHEMA` | n/a | <a href="https://attack.mitre.org/techniques/T1078/" target="_blank">T1078- Privilege Escalation</a> |
| `OBJECT_PRIVILEGES` | `GRANTOR`<br>`GRANTEE`<br>`PRIVILEGE_TYPE`<br>`IS_GRANTABLE`<br>`CREATED` | `INFORMATION_SCHEMA` | n/a | <a href="https://attack.mitre.org/techniques/T1078/" target="_blank">T1078- Privilege Escalation</a> |
| `ACCESS_HISTORY` | `QUERY_ID`<br>`QUERY_START_TIME`<br>`USER_NAME`<br>`DIRECT_OBJECTS_ACCESSED`<br>`BASE_OBJECTS_ACCESSSED` | `ACCOUNT_USAGE` | 3 hours | <a href="https://attack.mitre.org/techniques/T1078/" target="_blank">T1078- Valid Accounts</a> |
| `COPY_HISTORY` | All Applicable Columns | ``ACCOUNT_USAGE`` | 2 Hours | <a href="https://attack.mitre.org/techniques/T1213/" target="_blank">T1213- Data Collection</a><br><a href="https://attack.mitre.org/techniques/T1074/" target="_blank">T1074 - Data Staged</a> |
| `DATA_TRANSFER_HISTORY` | `START_TIME`<br>`END_TIME`<br>`SOURCE_CLOUD`<br>`SOURCE_REGION`<br>`TARGET_CLOUD`<br>`TARGET_REGION` | `ACCOUNT_USAGE` | 2 Hours | <a href="https://attack.mitre.org/techniques/T1213/" target="_blank">T1213- Data Collection</a><br><a href="https://attack.mitre.org/techniques/T1074/" target="_blank">T1074 - Data Staged</a> |
| `GRANTS_TO_ROLES` | `CREATED_ON`<br>`MODIFIED_ON`<br>`PRIVILEGE`<br>`GRANTED_ON`<br>`NAME`<br>`GRANTED_TO`<br>`GRANTEE_NAME`<br>`GRANT_OPTION`<br>`GRANTED_BY`<br>`DELETED_ON` | `ACCOUNT_USAGE` | 2 Hours | <a href="https://attack.mitre.org/techniques/T1078/" target="_blank">T1078- Privilege Escalation</a> |
| `GRANTS_TO_USERS` | `CREATED_ON`<br>`DELETED_ON`<br>`ROLE`<br>`GRANTED_TO`<br>`GRANTEE_NAME`<br>`GRANTED_BY` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1078/" target="_blank">T1078- Privilege Escalation</a> |
| `LOGIN_HISTORY` | `EVENT_TIMESTAMP`<br>`EVENT_TYPE`<br>`USER_NAME`<br>`CLIENT_IP`<br>`REPORTED_CLIENT_TYPE`<br>`FIRST_AUTHENTICATION_FACTOR`<br>`SECOND_AUTHENTICATION_FACTOR`<br>`IS_SUCCESS` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1078/" target="_blank">T1078.004- Cloud Accounts</a> |
| `MASKING_POLICIES` | `POLICY_NAME`<br>`CREATED`<br>`LAST_ALTERED`<br>`DELETED` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1080/" target="_blank">T1080- Taint Shared Content</a><br><a href="https://attack.mitre.org/tactics/TA0005/" target="_blank">TA0005 - Defense Evasion</a> |
| `QUERY_HISTORY` | All Applicable Columns | `ACCOUNT_USAGE` | 45 minutes | <a href="https://attack.mitre.org/tactics/TA0003/" target="_blank">TA0003 - Persistence</a><br><a href="https://attack.mitre.org/tactics/TA0003/" target="_blank">TA0003 - Valid Accounts</a> |
| `ROLES` | `CREATED_ON`<br>`DELETED_ON`<br>`NAME` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/tactics/TA0003/" target="_blank">TA0003 - Persistence</a> |
| `ROW_ACCESS_POLICIES` | `POLICY_NAME`<br>`CREATED`<br>`LAST_ALTERED`<br>`DELETED` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1080/" target="_blank">T1080- Taint Shared Content</a><br><a href="https://attack.mitre.org/tactics/TA0005/" target="_blank">TA0005 - Defense Evasion</a> |
| `SESSIONS` | `SESSION_ID`<br>`CREATED_ON`<br>`USER_NAME`<br>`AUTHENTICATION_METHOD`<br>`LOGIN_EVENT_ID`<br>`CLIENT_APPLICATION_VERSION`<br>`CLIENT_APPLICATION_ID`<br>`CLIENT_ENVIORNMENT`<br>`CLIENT_BUILD_ID`<br>`CLIENT_VERSION` | `ACCOUNT_USAGE` | 3 hours | <a href="https://attack.mitre.org/tactics/TA0003/" target="_blank">TA0003 - Persistence</a><br><a href="https://attack.mitre.org/techniques/T1550/" target="_blank">T1550 - Use Alternate Authentication Material</a> |
| `STAGES` | `STAGE_NAME`<br>`CREATED`<br>`LAST_ALTERED`<br>`DELETED` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1074/" target="_blank">T1074 - Data Staged</a> |
| `USERS` | All Applicable Columns | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/tactics/TA0003/" target="_blank">TA0003 - Persistence</a><br><a href="https://attack.mitre.org/tactics/TA0003/" target="_blank">TA0003 - Valid Accounts</a> |
| `DATABASES` | `DATABASE_NAME`<br>`CREATED`<br>`LAST_ALTERED`<br>`DELETED` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1074/" target="_blank">T1074 - Data Staged</a> |
| `TABLES` | `TABLE_OWNER`<br>`CREATED`<br>`LAST_ALTERED`<br>`DELETED` | `ACCOUNT_USAGE` | 2 hours | <a href="https://attack.mitre.org/techniques/T1074/" target="_blank">T1074 - Data Staged</a> |
