#!/bin/bash
# echo "create a new function"
FOLDER_PATH=$(pwd)
RELATIVE_PATH=$(pwd|grep -E '(^\/.*src)' -o)
FUNCTION_NAME=$(pwd|grep -E '(\w+$)' -o)

echo "Do you want create function template in ${FOLDER_PATH}"
echo "Do you want create function template ${FUNCTION_NAME} (WRITE: CREATE) "
read CREATE

if [[ $CREATE != "CREATE" ]]; then
  echo "No create"
  exit 1
else
  echo "Start create"
fi

cp "${RELATIVE_PATH}/utils/createFunctions/index.js" .
cp "${RELATIVE_PATH}/utils/createFunctions/schemaValidation.js" .
cp "${RELATIVE_PATH}/utils/createFunctions/inputOutputData.js" .
cp "${RELATIVE_PATH}/utils/createFunctions/index.test.js" .

REGEX_PATH='\/src\/(.*)'

FUNCTION_NAME=$(pwd|grep -E '(\w+$)' -o)


[[ $FOLDER_PATH =~ $REGEX_PATH ]]
UTIL_PATH=${BASH_REMATCH[1]}

UTIL_PATH_PROSED=$(echo $UTIL_PATH | sed 's_/_\\/_g')
TEST_PATH="${RELATIVE_PATH}/__tests__/${UTIL_PATH}"

mkdir -p ${TEST_PATH}

sed -i '' "s/{SCHEMA_VALIDATION_PATH}/${UTIL_PATH_PROSED}\/schemaValidation/g" index.js

sed -i '' "s/{FUNCTION_INDEX}/${FUNCTION_NAME}/g" index.test.js
sed -i '' "s/{FUNCTION_INDEX_PATH}/${UTIL_PATH_PROSED}/g" index.test.js
sed -i '' "s/{INPUT_OUTPUT_PATH}/${UTIL_PATH_PROSED}\/inputOutputData/g" index.test.js

mv index.test.js ${TEST_PATH}
