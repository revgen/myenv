#!/bin/sh

debug() { if [ "${DEBUG}" == "true" ]; then >2 echo "$@"; fi; }

replace_non_printable() {
    char=${1:-"_"}
    sed 's/[^[:print:]\r\t]/'${char}'/g'
}

test_jwt() {
    jwt="${1}"
    section="${2}"
    expected="${3}"
    echo  "Test JWT decoder: echo JWT | ./jwt-decode ${section}"
    debug "  JWT     : ${jwt}"
    debug "  Section : ${section}"
    value=$(echo "${jwt}" | ./jwt-decode ${section} 2>&1 | replace_non_printable "_")
    debug "  Value   : ${value}"
    debug "  Expected: ${expected}"
    if [ "${value}" == "${expected}" ]; then echo "☑ Success";
    else echo  "✘ Failed: '${value}' != '${expected}'"; return 1; fi
}


cd $(dirname "${0}")/..
echo "Working directory: ${PWD}"
errcode=0
jwt_test_value="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwidG9rZW4iOiI2Mjk5OUE2Mi1BMTAwLTQ4NEItQTBDMy1EQkE0MjQ4NzhGRDIifQ.EUcJuXk33JFs-DC9b5aiBieKs9EyROUkqjWMtQJUdLk"

test_jwt "${jwt_test_value}" 0 "Error: unknown argument '0'" || errcode=1
test_jwt "${jwt_test_value}" 1 '{"alg":"HS256","typ":"JWT"}' || errcode=1
test_jwt "${jwt_test_value}" header '{"alg":"HS256","typ":"JWT"}' || errcode=1
test_jwt "${jwt_test_value}" 2 '{"sub":"1234567890","name":"John Doe","token":"62999A62-A100-484B-A0C3-DBA424878FD2"}' || errcode=1
test_jwt "${jwt_test_value}" payload '{"sub":"1234567890","name":"John Doe","token":"62999A62-A100-484B-A0C3-DBA424878FD2"}' || errcode=1
test_jwt "${jwt_test_value}" 3 "_G__y7__l_0_o___'___2D_\$_5___Tt_" || errcode=1
test_jwt "${jwt_test_value}" signature "_G__y7__l_0_o___'___2D_\$_5___Tt_" || errcode=1
test_jwt "${jwt_test_value}" 4 "Error: unknown argument '4'" || errcode=1
test_jwt "${jwt_test_value}" command3 "Error: unknown argument 'command3'" || errcode=1

jwt_test_value="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSmFuZSBTbWl0aCIsImFnZSI6NTJ9.s3p2xCo8uXw6jKOiqdAF5iG7PamYA4pCt3OLvnr5H8g"
test_jwt "${jwt_test_value}" header '{"alg":"HS256","typ":"JWT"}' || errcode=1
test_jwt "${jwt_test_value}" secret '{"name":"Jane Smith","age":52}' || errcode=1
test_jwt "${jwt_test_value}" signature "_zv_*<_|:_______!_=____B_s__z___" || errcode=1

if [ $errcode -eq 0 ]; then echo "☑ All tests passed";
else echo "✘ Some tests failed!"; exit 1; fi

