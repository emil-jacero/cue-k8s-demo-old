package clusters

// import (
// 	cluster "github.com/emil-jacero/cue-demo/modules/cluster@v0"
// )

#ClusterOverrides: {
    clusterName:   string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
    clusterFQDN:   string & =~"^[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9](?:\\.[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9])+$"
    ...
}

#ClusterConfig: {
	name:         string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
    domainSuffix: string & =~"^[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9](?:\\.[a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9])+$"
    labels:     {[string]: string}
    clusterOverrides: #ClusterOverrides
    apps: {...}
    bundles: {...}
    flavor: {...}
    ...
}

#MyClusterOverrides: {
    clusterName:   string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
    clusterRole:   string & =~"^[a-z0-9]([a-z0-9\\-]){0,61}[a-z0-9]$"
    clusterFQDN:   string
    apps: {...}
    bundles: {...}
    flavor: {...}
    ...
}

#MyClusterConfig: #ClusterConfig & {
    role:         string
    clusterOverrides: #MyClusterOverrides
    ...
}
