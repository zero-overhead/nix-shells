{   pkgs ? import <nixpkgs> {},
    stdenvNoCC,
    jupyter
}:
let
    pname = "jupyter-chatbook";
    version = "0.3.4";
    author = "zef:antononcube";
    api = "1";
    
    # run for each user
    init-raku-chatbook-kernel = pkgs.writeShellScriptBin "init-raku-chatbook-kernel" ''
    # Copy this to:
    #let
    # Your API keys
    # OPENAI  = "browse https://platform.openai.com/api-keys";
    # MISTRAL  = "look at https://console.mistral.ai/api-keys";
    # PALM = "find help at https://github.com/antononcube/Raku-Jupyter-Chatbook";
    # GEMINI  = "read https://raku.land/zef:antononcube/Jupyter::Chatbook";
    # DEEPL  =  "use https://course.raku.org/";
    # WOLFRAM  = "visit https://rosettacode.org/wiki/Category:Raku";
    #in
    #pkgs.mkShell {
    #####################################################
    # Settings for Jupyter-Chatbook
    #####################################################
    #ZEF_FETCH_DEGREE = 4;
    #ZEF_TEST_DEGREE = 4;

    # Set your API keys
    #OPENAI_API_KEY = OPENAI;
    #MISTRAL_API_KEY  = MISTRAL;
    #PALM_API_KEY = PALM;
    #GEMINI_API_KEY  = GEMINI;
    #DEEPL_AUTH_KEY  = DEEPL;
    #WOLFRAM_ALPHA_API_KEY  = WOLFRAM;
    
    # pkgs.mkShell {
    #####################################################
    # Settings for Jupyter-Chatbook
    #####################################################
    #ZEF_FETCH_DEGREE = 4;
    #ZEF_TEST_DEGREE = 4;

    # Avoid this error: Cannot locate native library 'libreadline.so.7': libreadline.so.7: cannot open shared object file: No such file or directory
    # or: Cannot locate native library 'libssl.so': libssl.so: cannot open shared object file: No such file or directory
    # etc.
    #LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ 
    #    pkgs.readline70
    #    pkgs.openssl
    #    pkgs.zlib
    #    pkgs.zeromq
    #];
    #
    #shellHook =
    # export PATH="$HOME/.raku/bin:$PATH"
    # init-raku-chatbook-kernel
    # ...
    #
    #}

    export PATH="$HOME/.raku/bin:$PATH"
    export JUPYTER_KERNEL_DIR=$(jupyter --data)/kernels/raku
    
    #####################################################
    # Setup Jupyter-Chatbook
    #####################################################
    if [ -d "$JUPYTER_KERNEL_DIR" ]; then
        echo "Skipping Raku-Jupyter-Chatbook kernel setup, '$JUPYTER_KERNEL_DIR' already exists"
        echo "To trigger a fresh installation, delete the kernel directory: 'rm -rf $JUPYTER_KERNEL_DIR'"
    else
        echo "Initializing kernel and module installation"
        zef update
        zef --serial install "Jupyter::Chatbook:ver<${version}>:auth<${author}>:api<${api}>"
        jupyter-chatbook.raku --generate-config
    fi
    '';
in
stdenvNoCC.mkDerivation (finalAttrs: rec {
    inherit pname version author api;
    nativeBuildInputs = [
        pkgs.rakudo
        pkgs.zef
        pkgs.git
        pkgs.curl
        pkgs.wget
        pkgs.gcc
        pkgs.gnumake
        pkgs.readline70
        pkgs.cacert
        pkgs.zlib
        pkgs.openssl        
        pkgs.zeromq
        jupyter
        init-raku-chatbook-kernel
    ];

    propagatedBuildInputs = nativeBuildInputs;

    dontBuild = true;
    dontUnpack = true;
    dontConfigure = true;
})