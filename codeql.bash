#!/usr/bin/env bash

WD="${1:-$PWD}"
CODEQL_DIR="${2:- /opt/codeql-main}"

# update codeql git repository
# cd "$CODEQL_DIR"
# git pull

## remove duplicates
#fdupes --noempty --noprompt --quiet --recurse --delete "$WD"

# create codeql database
# cd "$WD"
DB_NAME=$1
# /opt/codeql/codeql database create "$DB_NAME" --language=javascript --threads=0 --quiet

# create symlink to codeql javascript lib
#ln -srf "${2:-"$HOME"/Desktop/codeql}"/javascript/ql/src ./jsql/
#ln -srf Self ./jsql/

# run a scan for Potential Security issues
while read -r QUERY; do
  /opt/codeql/codeql database analyze "$DB_NAME" ~/codeql/javascript/ql/src/"$QUERY" --format=csv --output=/tmp/"${QUERY##*/}".csv  --threads=0 --quiet
done <<-'EOF'
Security/CWE-079/UnsafeHtmlConstruction.ql
Security/CWE-079/UnsafeJQueryPlugin.ql
Security/CWE-079/XssThroughDom.ql
Security/CWE-079/ExceptionXss.ql
Security/CWE-079/Xss.ql
Security/CWE-079/ReflectedXss.ql
Security/CWE-079/StoredXss.ql
Security/CWE-601/ClientSideUrlRedirect.ql	
Security/CWE-754/UnvalidatedDynamicMethodCall.ql
Security/CWE-094/ImproperCodeSanitization.ql
Security/CWE-094/ExpressionInjection.ql
Security/CWE-094/UnsafeCodeConstruction.ql
Security/CWE-094/UnsafeDynamicMethodAccess.ql
Security/CWE-094/CodeInjection.ql
Security/CWE-830/FunctionalityFromUntrustedSource.ql
Security/CWE-598/SensitiveGetQuery.ql
Security/CWE-918/ClientSideRequestForgery.ql
Security/CWE-201/PostMessageStar.ql
Security/CWE-798/HardcodedCredentials.ql
Security/CWE-313/PasswordInConfigurationFile.ql
Security/CWE-073/TemplateObjectInjection.ql
Security/CWE-915/PrototypePollutingAssignment.ql
Security/CWE-915/PrototypePollutingMergeCall.ql
Security/CWE-020/ExternalAPIsUsedWithUntrustedData.ql
Security/CWE-020/MissingOriginCheck.ql
Security/CWE-020/IncompleteUrlSubstringSanitization.ql
Security/CWE-020/UntrustedDataToExternalAPI.ql
Security/CWE-020/IncompleteUrlSchemeCheck.ql
Security/CWE-020/IncompleteHostnameRegExp.ql
Security/CWE-843/TypeConfusionThroughParameterTampering.ql
Security/CWE-116/BadTagFilter.ql
Security/CWE-116/IncompleteSanitization.ql
Security/CWE-116/UnsafeHtmlExpansion.ql
Security/CWE-116/DoubleEscaping.ql
Security/CWE-116/IncompleteHtmlAttributeSanitization.ql
EOF
