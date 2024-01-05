script_folder="/home/lining/CLionProjects/openDevices/conan/build"
echo "echo Restoring environment" > "$script_folder/deactivate_conanrunenv-debug-x86_64.sh"
for v in OPENSSL_MODULES
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanrunenv-debug-x86_64.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanrunenv-debug-x86_64.sh"
    fi
done


export OPENSSL_MODULES="/home/lining/.conan2/p/b/opens79c593763dfb3/p/lib/ossl-modules"