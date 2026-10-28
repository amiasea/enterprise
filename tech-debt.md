### Promotional-Stage Identity Selection for ACA Jobs

**Current approach:** The ACA Job will be configured with both its SystemAssigned identity and the Workload UAMIs required to access promotional-stage databases.

**Limitation:** Unlike Terraform deployments that can use stage-specific OIDC workload federation, an ACA Job's managed identities must be attached to the Job resource in advance. This complicates dynamically selecting the appropriate identity for each promotional stage.

**Future consideration:** Evaluate an execution model that supports stage-specific workload identity federation, potentially using Kubernetes workload identity, or separate ACA Jobs per promotional stage.

**Risk:** A shared Job with multiple UAMIs has a broader set of available identities. Database targets and identity selection must be explicitly controlled to prevent cross-stage access.

### Public SQL Access

**Public network access to Azure SQL to avoid the additional cost of private networking infrastructure. Security will be enforced through cryptographic authentication, TLS, and explicit least-privilege authorization rather than treating network location as a basis for trust.
