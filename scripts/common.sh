
is_command() {
    command -v $1 \
    && echo true \
    || echo false
}
