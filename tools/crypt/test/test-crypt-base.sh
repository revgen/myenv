#!/bin/sh
set -a
set -e

cd $(dirname "${0}")
app=../crypt
tmpdir=/tmp/crypt-test
file1=${tmpdir}/test-file1.raw
file2=${tmpdir}/test-file2.raw
file3=${tmpdir}/test-file3.raw
hash_file=${tmpdir}/test-file.sha
pass=$(date +%s)
keyfile=${tmpdir}/keyfile

generate_test_data() {
    echo "Generate test data in ${tmpdir}"
    mkdir -p ${tmpdir} 2>/dev/null
    echo "Generate secret key: ${keyfile}"
    date | md5sum | cut -d" " -f1 > ${keyfile}

    echo "Generate file1"
    echo "Test file" > ${file1}
    for i in {0..10}; do
        date +%s >> ${file1}
    done
    ls -ahl ${file1}
    echo "Generate file2"
    cp /usr/bin/yes ${file2}
    ls -ahl ${file2}
    echo "Generate file3"
    head -n 100 /var/log/system.log > ${file3}
    ls -ahl ${file3}

}

generate_hash_file() {
    echo "Renerate hash file"
    rm -r ${hash_file} 2>/dev/null
    ls ${tmpdir}/test-file*.raw | while read f; do
        sha1sum ${f} >> ${hash_file}
    done
}

check_hash() {
    echo "Check files..."
    cat ${hash_file} | sed 's/\.raw$/\.raw\.new/g' > ${hash_file}.new.hash
    sha1sum -c ${hash_file}
    sha1sum -c ${hash_file}.new.hash
}

clean_test_data() {
    echo "Clean in ${tmpdir}"
    rm -rf "${tmpdir}"
}

run_test() {
    type=${1:-"7z"}
    clean_test_data
    generate_test_data
    generate_hash_file
    echo ">>> Test initialization: type=${type}"
    echo "Password=${pass}"
    echo ">>> Test  1..."
    echo "    Encrypting..."
    ${app} enc --${type} --password "${pass}" "${file1}" "${file1}.enc.${type}"
    echo "    Testing..."
    ${app} test --${type} --password "${pass}" "${file1}.enc.${type}" || exit 1
    echo "    Decrypting..."
    ${app} dec --${type} --password "${pass}" "${file1}.enc.${type}" "${file1}.new"
    echo ">>> Test  2..."
    echo "    Encrypting..."
    ${app} encrypt --${type} --password "${pass}" --base64 "${file2}" "${file2}.enc.${type}"
    echo "    Testing..."
    ${app} test --${type} --password "${pass}" --base64 "${file2}.enc.${type}" || exit 1
    echo "    Decrypting..."
    ${app} decrypt --${type} --password "${pass}" --base64 "${file2}.enc.${type}" "${file2}.new"
    echo ">>> Test  3..."
    echo "    Encrypting..."
    ${app} encrypt --${type} --keyfile "${keyfile}" "${file3}" "${file3}.enc.${type}"
    echo "    Testing..."
    ${app} test --${type} --keyfile "${keyfile}" "${file3}.enc.${type}" || exit 1
    echo "    Decrypting..."
    ${app} decrypt --${type} --keyfile "${keyfile}" "${file3}.enc.${type}" "${file3}.new"
    echo ">>> Test  4..."
    if [ ${type} == 'aes' ]; then
        test_text="Sample test $(date)"
        echo "Source text : ${test_text}"
        test_enc_text=$(echo "${test_text}" | ${app} enc --${type} --base64 --keyfile "${keyfile}")
        echo "---------"
        echo "${test_text}" | echo ${app} enc --${type} --base64 --keyfile "${keyfile}"
        echo "---------"
        echo "Encoded text: ${test_enc_text}"
        test_dec_text=$(echo "${test_enc_text}" | ${app} dec --${type} --base64 --keyfile "${keyfile}")
        echo "Decoded text: ${test_dec_text}"
        if [ "${test_text}" == "${test_dec_text}" ]; then
            echo "Success"
            check_hash
        else
            echo "Error test: source_text != decoded_text"
            return 1
        fi
    else
        echo "Skip this test for NON aes cryptography"
    fi
}

echo "Begin test script for encryption/decryption: ${app}"
echo "-------------------------------------------"
if [ -n "${1}" ]; then
    if [ "${1}" != "aes" ] && [ "${1}" != "7z" ]; then
        echo "Using: test <aes/7z>"
        exit 1
    fi
fi
run_test ${1} && \
    echo "" && \
    echo "-------------------------------------------" && \
    echo "Result: All test passed!"

echo "-------------------------------------------"
echo "End test script for encryption/decryption: ${app}"

