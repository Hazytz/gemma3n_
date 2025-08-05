if (current_message < 0)
    exit;

// Get the full text of the current message
var _str = messages[current_message].msg;

// If it's still typing
if (current_char < string_length(_str)) {
    current_char += char_speed * (1 + real(keyboard_check(input_key)));
    draw_message = string_copy(_str, 0, current_char);
    paginate_message(draw_message); // Re-paginate partial message
}
// If typing is finished and user presses the key
else if (keyboard_check_pressed(input_key)) {
    // Still more pages to show
    if (page_index < array_length(page_texts) - 1) {
        page_index++;
    }
    // Last page of current message
    else {
        current_message++;

        if (current_message >= array_length(messages)) {
            instance_destroy(); // Only destroy after last message + last page
        } else {
            // Setup next message
            current_char = 0;
            page_index = 0;
            paginate_message(""); // Clear old pages before next starts typing
        }
    }
}