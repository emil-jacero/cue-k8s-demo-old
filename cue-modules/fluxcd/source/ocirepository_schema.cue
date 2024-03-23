package source

import (
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	acl "github.com/emil-jacero/cue-demo/fluxcd/acl"
)

#OCIRepositoryKind: "OCIRepository"

// OCIRepositoryPrefix is the prefix used for OCIRepository URLs.
#OCIRepositoryPrefix: "oci://"

// GenericOCIProvider provides support for authentication using static credentials
// for any OCI compatible API such as Docker Registry, GitHub Container Registry,
// Docker Hub, Quay, etc.
#GenericOCIProvider: "generic"

// AmazonOCIProvider provides support for OCI authentication using AWS IRSA.
#AmazonOCIProvider: "aws"

// GoogleOCIProvider provides support for OCI authentication using GCP workload identity.
#GoogleOCIProvider: "gcp"

// AzureOCIProvider provides support for OCI authentication using a Azure Service Principal,
// Managed Identity or Shared Key.
#AzureOCIProvider: "azure"

// OCILayerExtract defines the operation type for extracting the content from an OCI artifact layer.
#OCILayerExtract: "extract"

// OCILayerCopy defines the operation type for copying the content from an OCI artifact layer.
#OCILayerCopy: "copy"

// OCIRepositorySpec defines the desired state of OCIRepository
#OCIRepositorySpec: {
	// URL is a reference to an OCI artifact repository hosted
	// on a remote container registry.
	// +kubebuilder:validation:Pattern="^oci://.*$"
	// +required
	url: string & =~"^oci://.*$"

	// The OCI reference to pull and monitor for changes,
	// defaults to the latest tag.
	// +optional
	ref?: null | #OCIRepositoryRef

	// LayerSelector specifies which layer should be extracted from the OCI artifact.
	// When not specified, the first layer found in the artifact is selected.
	// +optional
	layerSelector?: null | #OCILayerSelector

	// The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'.
	// When not specified, defaults to 'generic'.
	// +kubebuilder:validation:Enum=generic;aws;azure;gcp
	// +kubebuilder:default:=generic
	// +optional
	provider?: string

	// SecretRef contains the secret name containing the registry login
	// credentials to resolve image metadata.
	// The secret must be of type kubernetes.io/dockerconfigjson.
	// +optional
	secretRef?: null | meta.#LocalObjectReference

	// Verify contains the secret name containing the trusted public keys
	// used to verify the signature and specifies which provider to use to check
	// whether OCI image is authentic.
	// +optional
	verify?: null | #OCIRepositoryVerification

	// ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate
	// the image pull if the service account has attached pull secrets. For more information:
	// https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
	// +optional
	serviceAccountName?: string

	// CertSecretRef can be given the name of a Secret containing
	// either or both of
	//
	// - a PEM-encoded client certificate (`tls.crt`) and private
	// key (`tls.key`);
	// - a PEM-encoded CA certificate (`ca.crt`)
	//
	// and whichever are supplied, will be used for connecting to the
	// registry. The client cert and key are useful if you are
	// authenticating with a certificate; the CA cert is useful if
	// you are using a self-signed server certificate. The Secret must
	// be of type `Opaque` or `kubernetes.io/tls`.
	//
	// Note: Support for the `caFile`, `certFile` and `keyFile` keys have
	// been deprecated.
	// +optional
	certSecretRef?: null | meta.#LocalObjectReference

	// Interval at which the OCIRepository URL is checked for updates.
	// This interval is approximate and may be subject to jitter to ensure
	// efficient use of resources.
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
	// +required
	interval: #Duration

	// The timeout for remote OCI Repository operations like pulling, defaults to 60s.
	// +kubebuilder:default="60s"
	// +kubebuilder:validation:Type=string
	// +kubebuilder:validation:Pattern="^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
	// +optional
	timeout?: null | #Duration

	// Ignore overrides the set of excluded patterns in the .sourceignore format
	// (which is the same as .gitignore). If not provided, a default will be used,
	// consult the documentation for your version to find out what those are.
	// +optional
	ignore?: null | string

	// Insecure allows connecting to a non-TLS HTTP container registry.
	// +optional
	insecure?: bool

	// This flag tells the controller to suspend the reconciliation of this source.
	// +optional
	suspend?: bool
}

// OCIRepositoryRef defines the image reference for the OCIRepository's URL
#OCIRepositoryRef: {
	// Digest is the image digest to pull, takes precedence over SemVer.
	// The value should be in the format 'sha256:<HASH>'.
	// +optional
	digest?: string

	// SemVer is the range of tags to pull selecting the latest within
	// the range, takes precedence over Tag.
	// +optional
	semver?: string

	// Tag is the image tag to pull, defaults to latest.
	// +optional
	tag?: string
}

// OCILayerSelector specifies which layer should be extracted from an OCI Artifact
#OCILayerSelector: {
	// MediaType specifies the OCI media type of the layer
	// which should be extracted from the OCI Artifact. The
	// first layer matching this type is selected.
	// +optional
	mediaType?: string

	// Operation specifies how the selected layer should be processed.
	// By default, the layer compressed content is extracted to storage.
	// When the operation is set to 'copy', the layer compressed content
	// is persisted to storage as it is.
	// +kubebuilder:validation:Enum=extract;copy
	// +optional
	operation?: string
}

// OCIRepositoryVerification verifies the authenticity of an OCI Artifact
#OCIRepositoryVerification: {
	// Provider specifies the technology used to sign the OCI Artifact.
	// +kubebuilder:validation:Enum=cosign
	// +kubebuilder:default:=cosign
	provider: string

	// SecretRef specifies the Kubernetes Secret containing the
	// trusted public keys.
	// +optional
	secretRef?: null | meta.#LocalObjectReference

	// MatchOIDCIdentity specifies the identity matching criteria to use
	// while verifying an OCI artifact which was signed using Cosign keyless
	// signing. The artifact's identity is deemed to be verified if any of the
	// specified matchers match against the identity.
	// +optional
	matchOIDCIdentity?: [...#OIDCIdentityMatch]
}

// OIDCIdentityMatch specifies options for verifying the certificate identity,
// i.e. the issuer and the subject of the certificate.
#OIDCIdentityMatch: {
	// Issuer specifies the regex pattern to match against to verify
	// the OIDC issuer in the Fulcio certificate. The pattern must be a
	// valid Go regular expression.
	// +required
	issuer: string

	// Subject specifies the regex pattern to match against to verify
	// the identity subject in the Fulcio certificate. The pattern must
	// be a valid Go regular expression.
	// +required
	subject: string
}

// OCIRepositoryStatus defines the observed state of OCIRepository
#OCIRepositoryStatus: {
	// ObservedGeneration is the last observed generation.
	// +optional
	observedGeneration?: int64

	// Conditions holds the conditions for the OCIRepository.
	// +optional
	conditions?: [...metav1.#Condition]

	// URL is the download link for the artifact output of the last OCI Repository sync.
	// +optional
	url?: string @go(URL)

	// Artifact represents the output of the last successful OCI Repository sync.
	// +optional
	artifact?: null | apiv1.#Artifact

	// ContentConfigChecksum is a checksum of all the configurations related to
	// the content of the source artifact:
	//  - .spec.ignore
	//  - .spec.layerSelector
	// observed in .status.observedGeneration version of the object. This can
	// be used to determine if the content configuration has changed and the
	// artifact needs to be rebuilt.
	// It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`.
	//
	// Deprecated: Replaced with explicit fields for observed artifact content
	// config in the status.
	// +optional
	contentConfigChecksum?: string

	// ObservedIgnore is the observed exclusion patterns used for constructing
	// the source artifact.
	// +optional
	observedIgnore?: null | string

	// ObservedLayerSelector is the observed layer selector used for constructing
	// the source artifact.
	// +optional
	observedLayerSelector?: null | #OCILayerSelector

	meta.#ReconcileRequestStatus
}

// OCIPullFailedReason signals that a pull operation failed.
#OCIPullFailedReason: "OCIArtifactPullFailed"

// OCILayerOperationFailedReason signals that an OCI layer operation failed.
#OCILayerOperationFailedReason: "OCIArtifactLayerOperationFailed"

// OCIRepository is the Schema for the ocirepositories API
#OCIRepository: {
	metav1.#TypeMeta
	metadata?: metav1.#ObjectMeta
	spec?:     #OCIRepositorySpec
	status?: #OCIRepositoryStatus
}

// OCIRepositoryList contains a list of OCIRepository
// +kubebuilder:object:root=true
#OCIRepositoryList: {
	metav1.#TypeMeta
	metadata?: metav1.#ListMeta
	items: [...#OCIRepository]
}
