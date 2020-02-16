# Defined in /tmp/fish.Tg0fUL/down_node.fish @ line 2
function down_node
	set node_version (curl -s http://nodejs.org/dist/index.tab | awk '/^v[0-9]/{ print $1 }'| sort --version-sort -r |fzf --no-sort)
        mkdir -p $NODE_VERSIONS/$node_version
        curl -fsSL http://nodejs.org/dist/$node_version/node-$node_version-linux-x64.tar.gz | tar xvz --strip 1 -C $NODE_VERSIONS/$node_version
        mv  $NODE_VERSIONS/$node_version $NODE_VERSIONS/(echo $node_version|sed s/v//)
end
