#!/bin/bash
PARAM_ROLE_SESSION_NAME=$(eval echo "${PARAM_ROLE_SESSION_NAME}")

# echo 'export AWS_ACCESS_KEY_ID=""' >> "$BASH_ENV"
# echo 'export AWS_SECRET_ACCESS_KEY=""' >> "$BASH_ENV"

read -r AWS_ACCESS_KEY_ID_OIDC AWS_SECRET_ACCESS_KEY_OIDC AWS_SESSION_TOKEN_OIDC <<< \
"$(aws sts assume-role-with-web-identity \
--role-arn "${PARAM_AWS_CLI_ROLE_ARN}" \
--role-session-name "${PARAM_ROLE_SESSION_NAME}" \
--web-identity-token "${CIRCLE_OIDC_TOKEN}" \
--duration-seconds "${PARAM_SESSION_DURATION}" \
--query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' \
--output text)"

aws sts get-caller-identity

echo 'export AWS_ACCESS_KEY_ID_OIDC="${AWS_ACCESS_KEY_ID_OIDC}"' >> "$BASH_ENV"
echo 'export AWS_SECRET_ACCESS_KEY_OIDC="${AWS_SECRET_ACCESS_KEY_OIDC}"' >> "$BASH_ENV"
echo 'export AWS_SESSION_TOKEN_OIDC="${AWS_SESSION_TOKEN_OIDC}"' >> "$BASH_ENV"
echo 'export AWS_ACCESS_KEY_ID_OIDC=""' >> "$BASH_ENV"
echo 'export AWS_SECRET_ACCESS_KEY_OIDC=""' >> "$BASH_ENV"
echo 'export AWS_SESSION_TOKEN_OIDC=""' >> "$BASH_ENV"
echo 'export TEST=""' >> "$BASH_ENV"
# export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
# export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
# export AWS_SESSION_TOKEN="${AWS_SESSION_TOKEN}"
# echo "export AWS_ACCESS_KEY_ID=\"${AWS_ACCESS_KEY_ID}\"" >> "$BASH_ENV"
# echo "export AWS_SECRET_ACCESS_KEY=\"${AWS_SECRET_ACCESS_KEY}\"" >> "$BASH_ENV"
# echo "export AWS_SESSION_TOKEN=\"${AWS_SESSION_TOKEN}\"" >> "$BASH_ENV"




