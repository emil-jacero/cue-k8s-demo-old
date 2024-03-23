// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/grafana/grafana-operator/api/v1beta1

package v1beta1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	v13 "k8s.io/api/apps/v1"
	v14 "k8s.io/api/core/v1"
	"k8s.io/api/networking/v1"
	v12 "github.com/openshift/api/route/v1"
)

// ObjectMeta contains only a [subset of the fields included in k8s.io/apimachinery/pkg/apis/meta/v1.ObjectMeta](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.27/#objectmeta-v1-meta).
#ObjectMeta: {
	annotations?: {[string]: string} @go(Annotations,map[string]string)
	labels?: {[string]: string} @go(Labels,map[string]string)
}

#DeploymentV1: {
	metadata?: #ObjectMeta       @go(ObjectMeta)
	spec?:     #DeploymentV1Spec @go(Spec)
}

#DeploymentV1Spec: {
	// +optional
	replicas?: null | int32                        @go(Replicas,*int32) @protobuf(1,varint,opt)
	selector?: null | metav1.#LabelSelector        @go(Selector,*metav1.LabelSelector) @protobuf(2,bytes,opt)
	template?: null | #DeploymentV1PodTemplateSpec @go(Template,*DeploymentV1PodTemplateSpec) @protobuf(3,bytes,opt)

	// +optional
	// +patchStrategy=retainKeys
	strategy?: null | v13.#DeploymentStrategy @go(Strategy,*v13.DeploymentStrategy) @protobuf(4,bytes,opt)

	// +optional
	minReadySeconds?: int32 @go(MinReadySeconds) @protobuf(5,varint,opt)

	// +optional
	revisionHistoryLimit?: null | int32 @go(RevisionHistoryLimit,*int32) @protobuf(6,varint,opt)

	// +optional
	paused?:                  bool         @go(Paused) @protobuf(7,varint,opt)
	progressDeadlineSeconds?: null | int32 @go(ProgressDeadlineSeconds,*int32) @protobuf(9,varint,opt)
}

#DeploymentV1PodTemplateSpec: {
	// Standard object's metadata.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
	// +optional
	metadata?: #ObjectMeta @go(ObjectMeta) @protobuf(1,bytes,opt)

	// Specification of the desired behavior of the pod.
	// More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	// +optional
	spec?: null | #DeploymentV1PodSpec @go(Spec,*DeploymentV1PodSpec) @protobuf(2,bytes,opt)
}

#DeploymentV1PodSpec: {
	// +optional
	// +patchMergeKey=name
	// +patchStrategy=merge,retainKeys
	volumes?: [...v14.#Volume] @go(Volumes,[]v14.Volume) @protobuf(1,bytes,rep)

	// +patchMergeKey=name
	// +patchStrategy=merge
	// +optional
	initContainers?: [...v14.#Container] @go(InitContainers,[]v14.Container) @protobuf(20,bytes,rep)

	// +patchMergeKey=name
	// +patchStrategy=merge
	// +optional
	containers?: [...v14.#Container] @go(Containers,[]v14.Container) @protobuf(2,bytes,rep)

	// +optional
	// +patchMergeKey=name
	// +patchStrategy=merge
	ephemeralContainers?: [...v14.#EphemeralContainer] @go(EphemeralContainers,[]v14.EphemeralContainer) @protobuf(34,bytes,rep)

	// +optional
	restartPolicy?: v14.#RestartPolicy @go(RestartPolicy) @protobuf(3,bytes,opt,casttype=RestartPolicy)

	// +optional
	terminationGracePeriodSeconds?: null | int64 @go(TerminationGracePeriodSeconds,*int64) @protobuf(4,varint,opt)

	// +optional
	activeDeadlineSeconds?: null | int64 @go(ActiveDeadlineSeconds,*int64) @protobuf(5,varint,opt)

	// +optional
	dnsPolicy?: v14.#DNSPolicy @go(DNSPolicy) @protobuf(6,bytes,opt,casttype=DNSPolicy)

	// NodeSelector is a selector which must be true for the pod to fit on a node.
	// Selector which must match a node's labels for the pod to be scheduled on that node.
	// More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/
	// +optional
	// +mapType=atomic
	nodeSelector?: {[string]: string} @go(NodeSelector,map[string]string) @protobuf(7,bytes,rep)

	// ServiceAccountName is the name of the ServiceAccount to use to run this pod.
	// More info: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
	// +optional
	serviceAccountName?: string @go(ServiceAccountName) @protobuf(8,bytes,opt)

	// DeprecatedServiceAccount is a depreciated alias for ServiceAccountName.
	// Deprecated: Use serviceAccountName instead.
	// +k8s:conversion-gen=false
	// +optional
	serviceAccount?: string @go(DeprecatedServiceAccount) @protobuf(9,bytes,opt)

	// AutomountServiceAccountToken indicates whether a service account token should be automatically mounted.
	// +optional
	automountServiceAccountToken?: null | bool @go(AutomountServiceAccountToken,*bool) @protobuf(21,varint,opt)

	// NodeName is a request to schedule this pod onto a specific node. If it is non-empty,
	// the scheduler simply schedules this pod onto that node, assuming that it fits resource
	// requirements.
	// +optional
	nodeName?: string @go(NodeName) @protobuf(10,bytes,opt)

	// Host networking requested for this pod. Use the host's network namespace.
	// If this option is set, the ports that will be used must be specified.
	// Default to false.
	// +k8s:conversion-gen=false
	// +optional
	hostNetwork?: bool @go(HostNetwork) @protobuf(11,varint,opt)

	// Use the host's pid namespace.
	// Optional: Default to false.
	// +k8s:conversion-gen=false
	// +optional
	hostPID?: bool @go(HostPID) @protobuf(12,varint,opt)

	// Use the host's ipc namespace.
	// Optional: Default to false.
	// +k8s:conversion-gen=false
	// +optional
	hostIPC?: bool @go(HostIPC) @protobuf(13,varint,opt)

	// Share a single process namespace between all of the containers in a pod.
	// When this is set containers will be able to view and signal processes from other containers
	// in the same pod, and the first process in each container will not be assigned PID 1.
	// HostPID and ShareProcessNamespace cannot both be set.
	// Optional: Default to false.
	// +k8s:conversion-gen=false
	// +optional
	shareProcessNamespace?: null | bool @go(ShareProcessNamespace,*bool) @protobuf(27,varint,opt)

	// SecurityContext holds pod-level security attributes and common container settings.
	// Optional: Defaults to empty.  See type description for default values of each field.
	// +optional
	securityContext?: null | v14.#PodSecurityContext @go(SecurityContext,*v14.PodSecurityContext) @protobuf(14,bytes,opt)

	// ImagePullSecrets is an optional list of references to secrets in the same namespace to use for pulling any of the images used by this PodSpec.
	// If specified, these secrets will be passed to individual puller implementations for them to use.
	// More info: https://kubernetes.io/docs/concepts/containers/images#specifying-imagepullsecrets-on-a-pod
	// +optional
	// +patchMergeKey=name
	// +patchStrategy=merge
	imagePullSecrets?: [...v14.#LocalObjectReference] @go(ImagePullSecrets,[]v14.LocalObjectReference) @protobuf(15,bytes,rep)

	// Specifies the hostname of the Pod
	// If not specified, the pod's hostname will be set to a system-defined value.
	// +optional
	hostname?: string @go(Hostname) @protobuf(16,bytes,opt)

	// If specified, the fully qualified Pod hostname will be "<hostname>.<subdomain>.<pod namespace>.svc.<cluster domain>".
	// If not specified, the pod will not have a domainname at all.
	// +optional
	subdomain?: string @go(Subdomain) @protobuf(17,bytes,opt)

	// If specified, the pod's scheduling constraints
	// +optional
	affinity?: null | v14.#Affinity @go(Affinity,*v14.Affinity) @protobuf(18,bytes,opt)

	// If specified, the pod will be dispatched by specified scheduler.
	// If not specified, the pod will be dispatched by default scheduler.
	// +optional
	schedulerName?: string @go(SchedulerName) @protobuf(19,bytes,opt)

	// If specified, the pod's tolerations.
	// +optional
	tolerations?: [...v14.#Toleration] @go(Tolerations,[]v14.Toleration) @protobuf(22,bytes,opt)

	// HostAliases is an optional list of hosts and IPs that will be injected into the pod's hosts
	// file if specified. This is only valid for non-hostNetwork pods.
	// +optional
	// +patchMergeKey=ip
	// +patchStrategy=merge
	hostAliases?: [...v14.#HostAlias] @go(HostAliases,[]v14.HostAlias) @protobuf(23,bytes,rep)

	// If specified, indicates the pod's priority. "system-node-critical" and
	// "system-cluster-critical" are two special keywords which indicate the
	// highest priorities with the former being the highest priority. Any other
	// name must be defined by creating a PriorityClass object with that name.
	// If not specified, the pod priority will be default or zero if there is no
	// default.
	// +optional
	priorityClassName?: string @go(PriorityClassName) @protobuf(24,bytes,opt)

	// The priority value. Various system components use this field to find the
	// priority of the pod. When Priority Admission Controller is enabled, it
	// prevents users from setting this field. The admission controller populates
	// this field from PriorityClassName.
	// The higher the value, the higher the priority.
	// +optional
	priority?: null | int32 @go(Priority,*int32) @protobuf(25,bytes,opt)

	// Specifies the DNS parameters of a pod.
	// Parameters specified here will be merged to the generated DNS
	// configuration based on DNSPolicy.
	// +optional
	dnsConfig?: null | v14.#PodDNSConfig @go(DNSConfig,*v14.PodDNSConfig) @protobuf(26,bytes,opt)

	// If specified, all readiness gates will be evaluated for pod readiness.
	// A pod is ready when all its containers are ready AND
	// all conditions specified in the readiness gates have status equal to "True"
	// More info: https://git.k8s.io/enhancements/keps/sig-network/580-pod-readiness-gates
	// +optional
	readinessGates?: [...v14.#PodReadinessGate] @go(ReadinessGates,[]v14.PodReadinessGate) @protobuf(28,bytes,opt)

	// RuntimeClassName refers to a RuntimeClass object in the node.k8s.io group, which should be used
	// to run this pod.  If no RuntimeClass resource matches the named class, the pod will not be run.
	// If unset or empty, the "legacy" RuntimeClass will be used, which is an implicit class with an
	// empty definition that uses the default runtime handler.
	// More info: https://git.k8s.io/enhancements/keps/sig-node/585-runtime-class
	// +optional
	runtimeClassName?: null | string @go(RuntimeClassName,*string) @protobuf(29,bytes,opt)

	// EnableServiceLinks indicates whether information about services should be injected into pod's
	// environment variables, matching the syntax of Docker links.
	// Optional: Defaults to true.
	// +optional
	enableServiceLinks?: null | bool @go(EnableServiceLinks,*bool) @protobuf(30,varint,opt)

	// PreemptionPolicy is the Policy for preempting pods with lower priority.
	// One of Never, PreemptLowerPriority.
	// Defaults to PreemptLowerPriority if unset.
	// +optional
	preemptionPolicy?: null | v14.#PreemptionPolicy @go(PreemptionPolicy,*v14.PreemptionPolicy) @protobuf(31,bytes,opt)

	// Overhead represents the resource overhead associated with running a pod for a given RuntimeClass.
	// This field will be autopopulated at admission time by the RuntimeClass admission controller. If
	// the RuntimeClass admission controller is enabled, overhead must not be set in Pod create requests.
	// The RuntimeClass admission controller will reject Pod create requests which have the overhead already
	// set. If RuntimeClass is configured and selected in the PodSpec, Overhead will be set to the value
	// defined in the corresponding RuntimeClass, otherwise it will remain unset and treated as zero.
	// More info: https://git.k8s.io/enhancements/keps/sig-node/688-pod-overhead/README.md
	// +optional
	overhead?: v14.#ResourceList @go(Overhead) @protobuf(32,bytes,opt)

	// TopologySpreadConstraints describes how a group of pods ought to spread across topology
	// domains. Scheduler will schedule pods in a way which abides by the constraints.
	// All topologySpreadConstraints are ANDed.
	// +optional
	// +patchMergeKey=topologyKey
	// +patchStrategy=merge
	// +listType=map
	// +listMapKey=topologyKey
	// +listMapKey=whenUnsatisfiable
	topologySpreadConstraints?: [...v14.#TopologySpreadConstraint] @go(TopologySpreadConstraints,[]v14.TopologySpreadConstraint) @protobuf(33,bytes,opt)

	// If true the pod's hostname will be configured as the pod's FQDN, rather than the leaf name (the default).
	// In Linux containers, this means setting the FQDN in the hostname field of the kernel (the nodename field of struct utsname).
	// In Windows containers, this means setting the registry value of hostname for the registry key HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters to FQDN.
	// If a pod does not have FQDN, this has no effect.
	// Default to false.
	// +optional
	setHostnameAsFQDN?: null | bool @go(SetHostnameAsFQDN,*bool) @protobuf(35,varint,opt)

	// Specifies the OS of the containers in the pod.
	// Some pod and container fields are restricted if this is set.
	//
	// If the OS field is set to linux, the following fields must be unset:
	// -securityContext.windowsOptions
	//
	// If the OS field is set to windows, following fields must be unset:
	// - spec.hostPID
	// - spec.hostIPC
	// - spec.hostUsers
	// - spec.securityContext.seLinuxOptions
	// - spec.securityContext.seccompProfile
	// - spec.securityContext.fsGroup
	// - spec.securityContext.fsGroupChangePolicy
	// - spec.securityContext.sysctls
	// - spec.shareProcessNamespace
	// - spec.securityContext.runAsUser
	// - spec.securityContext.runAsGroup
	// - spec.securityContext.supplementalGroups
	// - spec.containers[*].securityContext.seLinuxOptions
	// - spec.containers[*].securityContext.seccompProfile
	// - spec.containers[*].securityContext.capabilities
	// - spec.containers[*].securityContext.readOnlyRootFilesystem
	// - spec.containers[*].securityContext.privileged
	// - spec.containers[*].securityContext.allowPrivilegeEscalation
	// - spec.containers[*].securityContext.procMount
	// - spec.containers[*].securityContext.runAsUser
	// - spec.containers[*].securityContext.runAsGroup
	// +optional
	os?: null | v14.#PodOS @go(OS,*v14.PodOS) @protobuf(36,bytes,opt)

	// Use the host's user namespace.
	// Optional: Default to true.
	// If set to true or not present, the pod will be run in the host user namespace, useful
	// for when the pod needs a feature only available to the host user namespace, such as
	// loading a kernel module with CAP_SYS_MODULE.
	// When set to false, a new userns is created for the pod. Setting false is useful for
	// mitigating container breakout vulnerabilities even allowing users to run their
	// containers as root without actually having root privileges on the host.
	// This field is alpha-level and is only honored by servers that enable the UserNamespacesSupport feature.
	// +k8s:conversion-gen=false
	// +optional
	hostUsers?: null | bool @go(HostUsers,*bool) @protobuf(37,bytes,opt)
}

#IngressNetworkingV1: {
	metadata?: #ObjectMeta            @go(ObjectMeta)
	spec?:     null | v1.#IngressSpec @go(Spec,*v1.IngressSpec)
}

#RouteOpenshiftV1: {
	metadata?: #ObjectMeta                  @go(ObjectMeta)
	spec?:     null | #RouteOpenShiftV1Spec @go(Spec,*RouteOpenShiftV1Spec)
}

#RouteOpenShiftV1Spec: {
	host?: string                           @go(Host) @protobuf(1,bytes,opt)
	path?: string                           @go(Path) @protobuf(2,bytes,opt)
	to?:   null | v12.#RouteTargetReference @go(To,*v12.RouteTargetReference) @protobuf(3,bytes,opt)
	alternateBackends?: [...v12.#RouteTargetReference] @go(AlternateBackends,[]v12.RouteTargetReference) @protobuf(4,bytes,rep)
	port?:           null | v12.#RoutePort   @go(Port,*v12.RoutePort) @protobuf(5,bytes,opt)
	tls?:            null | v12.#TLSConfig   @go(TLS,*v12.TLSConfig) @protobuf(6,bytes,opt)
	wildcardPolicy?: v12.#WildcardPolicyType @go(WildcardPolicy) @protobuf(7,bytes,opt)
}

#ServiceV1: {
	metadata?: #ObjectMeta             @go(ObjectMeta)
	spec?:     null | v14.#ServiceSpec @go(Spec,*v14.ServiceSpec)
}

#PersistentVolumeClaimV1: {
	metadata?: #ObjectMeta                         @go(ObjectMeta)
	spec?:     null | #PersistentVolumeClaimV1Spec @go(Spec,*PersistentVolumeClaimV1Spec)
}

#PersistentVolumeClaimV1Spec: {
	// +optional
	accessModes?: [...v14.#PersistentVolumeAccessMode] @go(AccessModes,[]v14.PersistentVolumeAccessMode) @protobuf(1,bytes,rep,casttype=PersistentVolumeAccessMode)

	// +optional
	selector?: null | metav1.#LabelSelector @go(Selector,*metav1.LabelSelector) @protobuf(4,bytes,opt)

	// +optional
	resources?: null | v14.#ResourceRequirements @go(Resources,*v14.ResourceRequirements) @protobuf(2,bytes,opt)

	// VolumeName is the binding reference to the PersistentVolume backing this claim.
	// +optional
	volumeName?: string @go(VolumeName) @protobuf(3,bytes,opt)

	// +optional
	storageClassName?: null | string @go(StorageClassName,*string) @protobuf(5,bytes,opt)

	// +optional
	volumeMode?: null | v14.#PersistentVolumeMode @go(VolumeMode,*v14.PersistentVolumeMode) @protobuf(6,bytes,opt,casttype=PersistentVolumeMode)

	// +optional
	dataSource?: null | v14.#TypedLocalObjectReference @go(DataSource,*v14.TypedLocalObjectReference) @protobuf(7,bytes,opt)

	// +optional
	dataSourceRef?: null | v14.#TypedLocalObjectReference @go(DataSourceRef,*v14.TypedLocalObjectReference) @protobuf(8,bytes,opt)
}

#ServiceAccountV1: {
	metadata?: #ObjectMeta @go(ObjectMeta)
	secrets?: [...v14.#ObjectReference] @go(Secrets,[]v14.ObjectReference) @protobuf(2,bytes,rep)

	// +optional
	imagePullSecrets?: [...v14.#LocalObjectReference] @go(ImagePullSecrets,[]v14.LocalObjectReference) @protobuf(3,bytes,rep)

	// +optional
	automountServiceAccountToken?: null | bool @go(AutomountServiceAccountToken,*bool) @protobuf(4,varint,opt)
}
