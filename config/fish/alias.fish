# Define the input and output file paths
set input_file "../bash_files/bash_aliases"
set output_file "/tmp/fish_aliases"


# Translate bash aliases
./bash_to.fish  $input_file $output_file

source output_file
