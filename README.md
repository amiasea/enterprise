# Amiasea Enterprise

Amiasea Enterprise is the enterprise domain of Amiasea.

It establishes the enterprise authority, identity base, application role, application-to-data-plane relationships, enterprise-owned resources, and security boundaries through which the Enterprise operates.

It is broader than the Amiasea Enterprise application and is not synonymous with Enterprise Core, Enterprise Host, or any particular application implementation.

The governing principle is:

> **Enterprise establishes what is authoritative; structure establishes where authority is separated; the data plane establishes how application concerns are organized within those boundaries.**

---

## Enterprise Authority

Amiasea Enterprise owns the concerns that are authoritative at the Enterprise level.

These include:

* the Enterprise application role;
* the Enterprise identity base;
* Enterprise-level identity relationships;
* Enterprise-owned capabilities and entitlements;
* Enterprise-level configuration and policy;
* Enterprise-level resources; and
* the relationship between Enterprise identities and Enterprise application contexts.

Enterprise does **not** thereby become the authority for identities when those identities are established by an external identity provider.

Likewise, Enterprise does not become synonymous with any particular application implementation or infrastructure realization.

```text
Amiasea
│
└── Amiasea Enterprise
    │
    ├── Enterprise-owned concerns
    ├── Enterprise identity base
    └── Enterprise application role
         ├── application implementation(s)
         └── application instance(s)
```

The Enterprise application role is durable. Its implementations and instances are replaceable.

---

## Enterprise Identity Base

The **Enterprise Identity Base is the singular Enterprise-level identity foundation through which authoritative external identities are recognized by Amiasea Enterprise and from which contextual application-user relationships are established.**

The external identity provider establishes authoritative external identity and credentials. Amiasea Enterprise consumes those identities and establishes application relationships with them.

```text
Identity Provider
      │
      │ authoritative identity
      │ + credentials
      ▼
Amiasea Enterprise
      │
      └── Enterprise Identity Base
            │
            ├── Development application relationship
            └── Production application relationship
```

Amiasea does not create a competing authoritative notion of human identity.

Development and Production do **not** establish separate identity bases. They establish separate application-to-data-plane relationships with identities already recognized by the same Enterprise Identity Base.

The same external identity therefore uses the same authoritative credentials in both contexts.

What differs between contexts is not **who the identity is**, but the identity's **application relationship, authorization, application-user state, and data access** within that context.

### Enterprise Application Users

`Amiasea_Enterprise_User` is an application-domain representation of an external identity.

It is therefore different from the authoritative identity established by the IdP.

```text
External Identity
│
├── Enterprise application relationship — Development
│   └── Amiasea_Enterprise_User
│
└── Enterprise application relationship — Production
    └── Amiasea_Enterprise_User
```

The two application representations may have different roles, capabilities, entitlements, state, or relationships while referring to the same external identity.

The application user is therefore an **avatar of an external identity within an application context**, not the authoritative identity itself.

---

## Enterprise Application Role

The Enterprise application is a logical application role owned by Amiasea Enterprise.

It is not a single immutable software deployment.

Multiple implementations may temporarily or permanently realize the same application role:

```text
Amiasea Enterprise
│
└── Enterprise application role
    │
    ├── Current implementation
    │   ├── Host
    │   ├── Core
    │   ├── API
    │   └── UI
    │
    └── Replacement implementation
        ├── Host
        ├── Core
        ├── API
        └── UI
```

Application replacement therefore does not replace the Enterprise identity base or the Enterprise itself.

During migration, multiple implementations may participate in the same Enterprise application role.

`Amiasea Enterprise Core` is an implementation/module boundary within this role. It is not the Enterprise identity.

---

## Application-to-Data-Plane Relationship

An **application-to-data-plane relationship** is the contextual association by which an application role is realized against a particular data plane, establishing the application's authority, identity, configuration, and access scope for that data plane.

The relationship is neither the application nor the data plane.

```text
Amiasea Enterprise
        │
        ▼
Enterprise application role
        │
        ├── Development application-to-data-plane relationship
        │       └── Development data plane
        │
        └── Production application-to-data-plane relationship
                └── Production data plane
```

Each relationship may establish its own:

* workload identity;
* authorization;
* configuration;
* application instance(s);
* application user relationships;
* capabilities and entitlements;
* operational state; and
* data access scope.

Both relationships nevertheless belong to the **same Enterprise application role**.

```text
                    Enterprise Application
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
   Application ↔ Development       Application ↔ Production
        data-plane relationship        data-plane relationship
              │                             │
        Development UAMI              Production UAMI
              │                             │
        Development SQL              Production SQL
              │                             │
       Development data             Production data
```

Development and Production are therefore not two applications. They are two application-to-data-plane relationships of one application role, each realized within its own security boundary.

---

## Structural Security Boundaries

The primary structural separation is currently:

```text
Amiasea Enterprise
│
├── Development security boundary
│   └── Development data plane
│
└── Production security boundary
    └── Production data plane
```

Development and Production have distinct Enterprise workload UAMIs and corresponding security conventions.

```text
Enterprise UAMI — Development
        │
        └── Development security boundary
             └── Development data plane

Enterprise UAMI — Production
        │
        └── Production security boundary
             └── Production data plane
```

This structural distinction is primarily motivated by security and operational authority.

It does **not** imply that every other Enterprise dimension must be duplicated structurally.

---

## Global Enterprise Resources

Globality is determined by **ownership and authority**, not by physical singleton status.

A resource is genuinely global when it belongs to an Amiasea or Enterprise concern that exists above the application data-plane segmentation.

For example:

```text
kv-amiasea-imperative
```

is an Amiasea enterprise/imperative concern.

Both Enterprise workload UAMIs may therefore require RBAC access to the same resource:

```text
Enterprise UAMI — Development ──┐
                                ├── RBAC → kv-amiasea-imperative
Enterprise UAMI — Production ───┘
```

By contrast, an Enterprise application concern may be globally meaningful to the application while having separate physical realizations within Development and Production.

Therefore:

> **Global does not necessarily mean physically singular.**

And:

> **Physically duplicated does not necessarily mean conceptually distinct.**

---

## Data Plane

The data plane carries dimensions that do not require structural infrastructure boundaries.

Development may contain the full spectrum of artifact and schema maturity:

```text
Speculative
Prospective
Operative
```

Production may principally contain mature artifacts and schemas while still containing multiple data segments and quality-assurance scopes.

These dimensions remain independent of the Development/Production security boundary.

For example, production may legitimately contain:

```text
Production
├── mature operational data
├── QA data
└── development-oriented data
```

The latter does not turn Production into a Development security boundary. It is a data-plane segmentation within Production.

Similarly, Development may contain mature artifacts:

```text
Development
├── speculative artifacts
├── prospective artifacts
└── mature artifacts
```

The location of an artifact does not establish its maturity.

---

## Maturity, QA, and Activation

Artifact maturity, schema maturity, quality assurance, deployment, and feature activation are independent dimensions.

A mature artifact can be deployed to Development.

A prospective artifact can be deployed to Production.

A prospective feature can remain disabled within Production or be selectively enabled for QA users.

```text
Production
│
└── deployed artifact
     │
     ├── existing behavior
     │
     └── prospective behavior
          ├── disabled
          ├── QA users
          ├── selected users
          └── generally enabled
```

Feature flags therefore provide a flexible organizational mechanism without requiring every state of the application to become a structural infrastructure boundary.

The eventual Amiasea system may develop explicit structures for Speculative, Prospective, and Operative states as its own engineering capabilities mature. The present infrastructure does not need to prematurely encode those dimensions as separate security boundaries.

---

## Resource Structure and Dimensionality

The Enterprise model is multidimensional.

In theory, every dimension could be represented structurally:

```text
[security]-[maturity]-[QA]-[tenant]-[region]-[...]
```

That is not necessarily desirable.

Structural containment carries cognitive, operational, naming, security, and infrastructure cost. Enterprise infrastructure therefore uses the minimum structural dimensions necessary to express meaningful boundaries.

A structural boundary should have an identifiable motive, such as:

* security;
* authority;
* administrative ownership;
* geography;
* regulatory isolation;
* availability;
* lifecycle; or
* another requirement that materially requires physical or infrastructure separation.

Other dimensions should generally remain in:

* the data plane;
* configuration;
* relationships;
* claims;
* policy; or
* feature activation.

The goal is not to prevent multidimensional modeling.

The goal is to prevent the infrastructure hierarchy from becoming a distorted representation of the complete domain model.

---

## Naming and Culture

Formal nomenclature establishes the dimensions and structural boundaries.

Cultural nomenclature provides ergonomic shorthand within those boundaries.

Consequently, terms such as:

* development;
* production;
* QA;
* test;
* prospective; and
* operative

may have contextual meanings that differ according to the dimension being discussed.

For example:

> "Development data in Production"

can be perfectly coherent when:

* `Production` identifies the security/data-plane boundary; and
* `Development` identifies a data segmentation within that boundary.

The formal model makes the contextual colloquialism intelligible.

> **Formal nomenclature defines the dimensions; culture provides ergonomic shorthand.**

Resource names therefore do not need to encode the complete multidimensional state of a resource.

---

## Environment

`environment` is not a primitive architectural concept of Amiasea Enterprise.

The term commonly conflates:

* security boundary;
* execution context;
* data-plane segmentation;
* artifact maturity;
* deployment target;
* infrastructure containment; and
* quality assurance.

Enterprise architecture therefore prefers terms that identify the actual dimension:

* **security boundary**
* **data plane**
* **data segmentation**
* **execution context**
* **application instance**
* **artifact maturity**
* **schema state**
* **quality-assurance scope**
* **deployment**
* **feature activation**

Where `development` or `production` is used colloquially, its meaning is established by the structural context in which it is used.

---

## Enterprise Data and SQL

SQL infrastructure realizes Enterprise data-plane boundaries; it does not define the complete Enterprise domain model.

A logical SQL Server is principally an infrastructure management, connectivity, and security realization. It should not automatically become the conceptual boundary for every Enterprise dimension.

The current structural model therefore permits:

```text
Development security boundary
    └── Development SQL realization

Production security boundary
    └── Production SQL realization
```

while the data within those realizations may independently represent:

* application users;
* capabilities;
* relationships;
* maturity;
* QA scopes;
* feature state;
* operational state; and
* other application-domain concerns.

A concept can therefore be globally meaningful while having separate data-plane representations.

---

## Enterprise vs. Amiasea Engineering

Amiasea Enterprise is part of Amiasea but is not a restatement of the Amiasea engineering model.

The engineering model governs how Amiasea establishes, promotes, realizes, and maintains engineering systems and artifacts.

The Enterprise domain governs:

* enterprise authority;
* enterprise identity;
* application relationships;
* application implementations;
* data planes;
* enterprise-owned resources;
* security boundaries; and
* the operational organization of the Enterprise application.

The two domains interact without becoming interchangeable.

Enterprise should therefore not be modeled merely as another engineering-model promotion environment.

---

## Architectural Principles

The Enterprise architecture can be reduced to the following principles:

1. **Enterprise owns Enterprise concerns.**
   Enterprise identity relationships, application role, enterprise policy, and enterprise resources belong to the Enterprise domain.

2. **The IdP owns authoritative identity.**
   Amiasea consumes external identity and establishes application relationships with it.

3. **The Enterprise Identity Base is singular.**
   There is one Enterprise-level identity foundation. Development and Production do not establish separate identities or credential populations; they establish contextual application relationships with identities recognized by that foundation.

4. **Application users are contextual representations.**
   `Amiasea_Enterprise_User` represents an external identity within the Enterprise application; it does not establish the authoritative identity itself.

5. **The Enterprise application role is durable.**
   Implementations and instances may be replaced without replacing the Enterprise application identity.

6. **An application-to-data-plane relationship establishes application context.**
   It connects an application role to a particular data plane and establishes the authority, workload identity, configuration, and access scope for that realization.

7. **Development and Production are structural security/data-plane boundaries.**
   They are not separate Enterprises, identities, or necessarily separate application roles.

8. **An application may have multiple data-plane relationships.**
   The same application role can be realized against independently secured data planes.

9. **Globality follows authority, not physical topology.**
   Enterprise-global resources may be singular; application-global concepts may have separate data-plane realizations.

10. **Structure represents motivated boundaries.**
    Infrastructure should not encode every domain dimension.

11. **The data plane represents remaining dimensions.**
    Maturity, QA, feature state, segmentation, and similar concerns can coexist within a structural boundary.

12. **Deployment does not determine maturity.**
    A mature artifact may be deployed to Development, and a prospective artifact may be deployed to Production.

13. **Feature activation is independent of artifact maturity.**
    Feature flags permit prospective behavior to cross structural boundaries without redefining those boundaries.

14. **Culture supplies ergonomic language.**
    Formal nomenclature establishes the dimensions; cultural terminology makes them practical to use.

The resulting model is intentionally multidimensional while keeping physical structure comprehensible:

```text
                         AMIASEA
                            │
                   AMIASEA ENTERPRISE
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
 Enterprise Authority   Identity Base    Application Role
                              │                 │
                         Enterprise CIAM        │
                                                │
                                  ┌─────────────┴─────────────┐
                                  │                           │
                             Development                  Production
                             security/data               security/data
                                boundary                    boundary
                                  │                           │
                              Data plane                   Data plane
                                  │                           │
                         maturity / QA /             mature artifacts /
                         segmentation /              QA / segmentation /
                         feature state              feature state
```

> **Structure establishes authority and isolation.
> The data plane establishes semantic organization.
> The IdP establishes authoritative identity.
> The Enterprise establishes application relationships.
> Infrastructure realizes the resulting model.**
