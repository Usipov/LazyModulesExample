#!/bin/bash
#
# Taken from https://gist.github.com/kam800/0d04917b4f051c1dd906d629d685f571
#
# This script checks the binary and all nested frameworks for duplicated classes (both ObjectiveC and Swift).
# The script fails if it finds any duplicated classes.

print_classes() {
    otool -ov "$1" | 
        sed -n '/Contents of (__DATA,__objc_classlist)/,/Contents of/p' | # all lines for (__DATA,__objc_classlist) section
        egrep '^[0-9]' |            # take just a class header
        cut -d ' ' -f 3 |           # take just a symbol name
        sort |                      # uniq requires sorted data
        uniq
}

print_allClasses() {
    print_classes "${EXECUTABLE_NAME}"      # print classes for main executable
    find Frameworks -name '*.framework' |   # and the rest of the frameworks
        while read framework_path
        do 
            local framework_name="$(basename -s .framework "${framework_path}")"
            print_classes "${framework_path}/${framework_name}"
        done
}

print_countsOfAllClasses() {
    print_allClasses |
        sort |              # uniq requires sorted data
        uniq -c             # uniq with count printing
}

print_countsOfDuplicatedClasses() {
    print_countsOfAllClasses |
        egrep -v '^ *1 '    # skip unique symbols
}

print_countsOfDuplicatedClassesWithoutIgnores() {
    print_countsOfDuplicatedClasses
    # To ignore duplicates, use following code.
#    print_countsOfDuplicatedClasses |
#        grep -v "2 _OBJC_CLASS_$_sampleIgnore1" |
#        grep -v "2 _OBJC_CLASS_$_sampleIgnore2" |
#        grep -v "2 _OBJC_CLASS_$_sampleIgnore3"
}

checkDuplicatedClasses() {
    local duplicated_files="$(print_countsOfDuplicatedClassesWithoutIgnores)"
    if [ -n "${duplicated_files}" ]; then
        echo "Duplicated symbols detected:"
        echo "${duplicated_files}"
        echo "If you want to ignore those symbols, then modify print_countsOfDuplicatedClassesWithoutIgnores() in $(basename $0)"
        exit 1
    else
        echo "No dublicated symbols found"
    fi
}

app_dir=${APP_BUILD_DIR:-${BUILT_PRODUCTS_DIR}/${EXECUTABLE_FOLDER_PATH}}
echo "Searching for dublicated symbols in ${app_dir}"
cd "${app_dir}" && checkDuplicatedClasses