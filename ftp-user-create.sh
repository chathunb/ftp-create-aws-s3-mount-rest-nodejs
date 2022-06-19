#!/bin/bash
# usage:

    csu_user=$1
    csu_password=$2
    csu_ssh_key=$3
    csu_super_flag=$4
    csu_bucket=$5
    csu_region=$6
    csu_override=$7

    # create user
    adduser $csu_user

    # set user password
    if [ "$csu_password" != "" ]; then
      echo "$csu_user:$csu_password" | chpasswd
    fi

    # prevent ssh login & assign SFTP group
    usermod -g sftpusers $csu_user
    #usermod -s /bin/nologin $csu_user

    # chroot user (so they only see their directory after login)
    chown root:$csu_user /home/$csu_user
    chmod 755 /home/$csu_user

    # set up upload directory tied to s3
    mkdir /home/$csu_user/ftp
    chown $csu_user:$csu_user /home/$csu_user/ftp
    chmod 755 /home/$csu_user/ftp
        usermod -d /home/$csu_user/ftp $csu_user
    # create matching folder in s3
    aws s3api put-object --bucket $csu_bucket --key $csu_user/

    # get user ids
    #usruid=`id -u $csu_user`
    #usrgid=`id -g $csu_user`

    # link upload dir to s3
    cat <<EOT >> /etc/fstab
    $csu_bucket:/$csu_user /home/$csu_user/ftp fuse.s3fs rw,nosuid,nodev,allow_other
EOT

 mount /home/$csu_user/ftp
