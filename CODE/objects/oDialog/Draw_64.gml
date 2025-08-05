var _dx   = 0;
var _dy   = gui_h * 0.7;
var _boxw = gui_w;
var _boxh = gui_h - _dy;

if (current_message >= 0 && current_message < array_length(messages)) {
    draw_sprite_stretched(sBox, 0, _dx, _dy, _boxw, _boxh);

    draw_set_font(Font1);
    draw_set_color(c_white);

    // speaker name
    var _name = messages[current_message].name;

    // text width matches your margin math:
    var textW = _boxw - _dx*2;

    // draw the paged text (instead of draw_message):
    draw_text_ext(_dx, _dy,_name+": "+page_texts[page_index], -1, textW);

    if (page_index < array_length(page_texts)-1) {
        draw_text(_dx, _dy + (_boxh - _dy) - 16, "(space to continue)");
    }
}

// advance page on ▶ key (keep it inside Draw GUI or in Step):
if (keyboard_check_pressed(input_key)
 && page_index < array_length(page_texts)-1) {
    page_index++;
}


with (oNPC1) {
    if (input_active) {
        draw_sprite_stretched(sBox, 0, _dx, _dy, _boxw, _boxh);

        draw_set_font(Font1);
        draw_set_color(c_white);

        // reuse same margins for input text
        draw_text_ext(_dx, _dy, "You: " + input_buffer, -1, display_get_gui_width() - 32);
    }
}

with (oNPC2) {
    if (input_active) {
        draw_sprite_stretched(sBox, 0, _dx, _dy, _boxw, _boxh);

        draw_set_font(Font1);
        draw_set_color(c_white);

        // reuse same margins for input text
        draw_text_ext(_dx, _dy, "You: " + input_buffer, -1, display_get_gui_width() - 32);
    }
}

with (oNPC3) {
    if (input_active) {
        draw_sprite_stretched(sBox, 0, _dx, _dy, _boxw, _boxh);

        draw_set_font(Font1);
        draw_set_color(c_white);

        // reuse same margins for input text
        draw_text_ext(_dx, _dy, "You: " + input_buffer, -1, display_get_gui_width() - 32);
    }
}
