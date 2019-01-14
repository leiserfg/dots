# Defined in /tmp/fish.PKITxL/fish_right_prompt.fish @ line 2
function fish_right_prompt
	if test $status -ne 0
  	set_color red
  	echo '!'
  end
  if test (jobs -l | wc -l) -gt 0
  	set_color aa00aa
  	echo '%'
  end
  __fish_git_prompt
  set_color blue
  _venv_prompt
  set_color normal
end
