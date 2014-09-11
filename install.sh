!usr/bin/sh
############################
# This script creates symlinks from the home DOTFILES_DIRectory to any desired dotfiles in ~/dotfiles
############################
########## Variables
DOTFILES_DIR=~/dotfiles # dotfiles directory
BACKUP_DIR=~/dotfiles_backup # old dotfiles backup directory
##########

echo -n "Creating $BACKUP_DIR for backup of any existing dotfiles in ~ ..."
mkdir -p $BACKUP_DIR
echo "done"

echo -n "Changing to the $DOTFILES_DIR directory ..."
cd $DOTFILES_DIR
echo "done"

for file in `ls $DOTFILES_DIR/ --ignore "install.sh" | grep -v "README.md"`; do
	if [[ -e ~/.$file ]] && [[ ! -L ~/.$file ]]
	then
		echo "Moving ~/.$file to $BACKUP_DIR"
		mv ~/.$file $BACKUP_DIR
	elif [[ -L ~/.$file ]]
	then
		echo "removing existing symlink ~/.$file"
		rm ~/.$file
	fi
	echo "Creating symlink to $file in home directory."
	ln -s $DOTFILES_DIR/$file ~/.$file
done

