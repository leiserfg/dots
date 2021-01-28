# Defined in /tmp/fish.896aQX/_venv_prompt.fish @ line 2
function _venv_prompt --description 'virtualenv segment'
	if test $VIRTUAL_ENV
       printf (set_color normal)'['(set_color blue)(basename $VIRTUAL_ENV|sed 's/python-//')(set_color normal)']'
  end
end
