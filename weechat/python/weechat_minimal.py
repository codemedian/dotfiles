import weechat as w

SCRIPT_NAME="minibar"
SCRIPT_AUTHOR="deadc0de"
SCRIPT_LICENSE=""
SCRIPT_DESC=""
SCRIPT_VERSION="0.0.1"

def minimal_bar_item_update (data=None, signal=None, signal_data=None):
  w.bar_item_update('minimal')
  return w.WEECHAT_RC_OK

def minimal_bar_item (data, item, window):
  if not window:
    window = w.current_window()
  ptr_buffer = w.window_get_pointer(window, "buffer")
  if ptr_buffer == "" or ptr_buffer == w.current_buffer():
    return ""
  length = w.window_get_integer(window, 'win_width') - w.buffer_get_integer(ptr_buffer, 'input_length')
  s = length * " "
  return s

if __name__ == "__main__":
  if w.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, "", ""):
    minimal_bar_item_update()
    w.hook_signal('buffer_switch', 'minimal_bar_item_update', '')
    w.bar_item_new('minimal', 'minimal_bar_item', '')
