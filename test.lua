local jdtls_install = require('mason-registry')
    .get_package('jdtls')
    :get_install_path()
print(jdtls_install)
