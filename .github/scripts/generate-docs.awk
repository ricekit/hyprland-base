BEGIN {
    prev_line = ""
    in_function = 0
}

# Store comment lines that appear before functions
/^#/ && !in_function {
    comment = $0
    sub(/^# ?/, "", comment)
    next
}

# Match function definition
/^[a-zA-Z_][a-zA-Z0-9_]*\(\)/ {
    func_name = $1
    sub(/\(\).*/, "", func_name)
    
    # Print function header
    print "### `" func_name "()`"
    print ""
    
    # Print comment if it exists
    if (comment != "") {
        print comment
        print ""
        comment = ""
    }
    
    in_function = 1
    brace_count = 0
    next
}

# Track braces to find function body
in_function {
    if ($0 ~ /{/) brace_count++
    if ($0 ~ /}/) brace_count--
    
    # End of function
    if (brace_count == 0 && $0 ~ /^}/) {
        in_function = 0
        print "---"
        print ""
    }
}

# Clear comment on blank lines when not in function
/^$/ && !in_function {
    comment = ""
}