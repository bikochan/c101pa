# Exports for shell config
export ANSIBLE_NOCOWS=1
export GOPATH=$HOME/go
export GPG_TTY=$(tty)
export HISTCONTROL=ignoredups
export HISTSIZE=5000
export HISTTIMEFORMAT="%F %T "

export PATH=$HOME/bin:/usr/local/go/bin:$PATH


# Setup prompt
source ${HOME}/bin/bash_prompt.sh

# Gcloud CLI
for f in /usr/local/google-cloud-sdk/path.bash.inc /usr/local/google-cloud-sdk/completion.bash.inc
do
    [ -f $f ] && source $f
done

# functions
function err() { printf "\e[31m${@}\e[0m" ; }
function ok()  { printf "\e[32m${@}\e[0m" ; }

# set AWS credentials
setaws()
{
    profile=${1:-default}
    sed -ne "/$profile/,/^$/p"  ~/.aws/credentials | \
        awk -F" = " '/=/ { print "export " toupper($1) "=" $2 }'
    echo "export AWS_SESSION_NAME=${USER}"
    echo "export AWS_CREDENTIAL_PROFILE=$profile"
}
$(setaws)

# set kubernetes context
ks ()
{
    f=~/.kube/$1/config
    if [ -f $f ]; then
        export KUBECONFIG=$f
        echo "Kubeconfig switched to:" $f
    else
        echo "Kubeconfig does not exist: " $f
    fi
}

# SSL cert check
sslok()
{
    port=${2:-443}
    echo | openssl s_client -showcerts -connect $1:$port 2>/dev/null | openssl x509 -text | cfssl certinfo -cert - | jq '"Common name:" , .subject.common_name, "Subject Names:", .subject.names[], "Not before:", .not_before, "Not After:" , .not_after, "SANs:" , .sans'
}
