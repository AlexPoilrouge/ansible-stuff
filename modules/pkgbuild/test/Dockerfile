FROM archlinux:latest

COPY docker/mirrorlist /etc/pacman.d/mirrorlist

RUN	 pacman -Syy

RUN	 pacman -S --noconfirm \
                base-devel \
                openssh \
                sudo \
                python \
                tar

RUN  /usr/bin/ssh-keygen -A

RUN  sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

EXPOSE	 22

ARG SSH_USER="ansible_test"
ARG SSH_PASSWORD="P@55w0rd"

RUN useradd -m ${SSH_USER}

RUN echo ${SSH_USER}:${SSH_PASSWORD} | chpasswd

RUN echo "${SSH_USER} ALL = (root) NOPASSWD:ALL" > /etc/sudoers.d/${SSH_USER}

RUN chmod 0400 /etc/sudoers.d/${SSH_USER}


ARG REPO_USER="repo"

RUN useradd -m ${REPO_USER}


CMD	 ["/usr/sbin/sshd", "-D"]
