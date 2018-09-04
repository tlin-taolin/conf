for USER in "xu" "johan" "hali"
do
    echo "Adding the user $USER"
    useradd $USER && echo "$USER:rstudio" | chpasswd
    mkdir /home/$USER && chown $USER:$USER /home/$USER
    addgroup $USER rstudio
    ln -s /home/rstudio/data "/home/$USER/data" && ln -s /home/rstudio/shared "/home/$USER/shared"
done
