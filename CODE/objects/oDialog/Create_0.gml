messages = [];
current_message = -1;
current_char = 0;
draw_message = "";
char_speed = 0.5;
input_key = vk_space;

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
page_index = 0;           // current page (starts at 0)
page_texts = [];