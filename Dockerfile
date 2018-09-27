FROM python:3.6.6-jessie

EXPOSE 8083

# Install Calibre through a PPA
RUN apt-get update && \
    apt-get install -y curl unzip libgl1-mesa-glx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install the AWS CLI
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    rm -rf awscli-bunzip.zip awscli-bundle

# Install Calibre
RUN wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin

#/usr/bin/calibredb add --empty "empty.epub" --title "Initialize Library" --with-library /calibre-server

COPY . .

RUN pip install --target vendor -r requirements.txt

ENTRYPOINT ["/usr/local/bin/python", "cps.py"]
