module: "github.com/emil-jacero/cue-demo/bundles/net_cilium@v0"
language: {
	version: "v0.8.0"
}
deps: {
	"github.com/emil-jacero/cue-demo/apps/cilium@v0": {
		v: "v0.7.0"
	}
	"github.com/emil-jacero/cue-demo/modules/bundle@v0": {
		v: "v0.8.0"
	}
	"github.com/emil-jacero/cue-demo/modules/fluxcd@v0": {
		v: "v0.4.0"
	}
	"github.com/fluxcd@v1": {
		v:       "v1.0.0"
		default: true
	}
	"k8s.io@v1": {
		v:       "v1.0.0"
		default: true
	}
}
