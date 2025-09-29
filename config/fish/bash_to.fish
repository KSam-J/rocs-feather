#!/usr/bin/env fish

function translate_bash_to_fish
    set -l input_file $argv[1]
    set -l output_file $argv[2]

    if test -z "$input_file" -o -z "$output_file"
        echo "Usage: $argv[0] <input_file> <output_file>"
        return 1
    end

    if not test -f "$input_file"
        echo "Input file does not exist."
        return 1
    end

    if test -f "$output_file"
        rm "$output_file"
    end

    # Read the input file line by line
    cat $input_file | while read -l line
        # Translate common Bash constructs to Fish equivalents
        set line (string replace -r '^\s*#' '#' $line)  # Comments
        set line (string replace -r '^\s*if\s*\[\s*(.*)\s*\]\s*;\s*then' 'if test $1; then' $line)  # If statements
        set line (string replace -r '^\s*fi\s*$' 'end' $line)  # End if
        set line (string replace -r '^\s*for\s*(.*)\s*in\s*(.*)\s*;\s*do' 'for $1 in $2; do' $line)  # For loops
        set line (string replace -r '^\s*done\s*$' 'end' $line)  # End for
        set line (string replace -r '^\s*while\s*\[\s*(.*)\s*\]\s*;\s*do' 'while test $1; do' $line)  # While loops
        set line (string replace -r '^\s*done\s*$' 'end' $line)  # End while

        # Append the translated line to the output file
        echo $line >> $output_file
    end

    echo "Translation complete. Output written to $output_file."
end

translate_bash_to_fish $argv

