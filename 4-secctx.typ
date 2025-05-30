#import "template.typ": *

#mol-chapter("Security Contexts")

Security Contexts are objects that store capabilites, which processes can attach onto, inherting the
permissions granted by the capabilities that reside inside. 

== Enforcement

The enforcement of security policy in Twizzler happens on page fault when trying to access
a new object @twizzler. Then the kernel inspects the security contexts attached to
the accessing proccess, looking up what capabilities those contexts hold and if they are applicable
to the object being accessed.  The original twizzler paper @twizzler, and the following security paper
go into more detail about the philosophy behind why enforcement works this way, such as the
performance benefits of letting programs access objects directly without kernel involvement, etc. 




== Base

Since security contexts can be interacted with by the kernel and userspace, there needs to
be a consistent defenition that both parties can adhere to, which we define. Objects in twizzler
have a notion of a `Base` which defines an arbitrary block of data at the "bottom" of an object
that is represented as a type in rust. We define the `Base` for a security context as follows:

```rust
struct SecCtxBase {
    map: Map<ObjID, Vec<CtxMapItem>>, /// A Map from ObjIDs to possible capabilities.
    masks: Map<ObjID, Mask>,          /// A map from ObjID's to masks.
    global_mask: Protections,         /// Global mask that applies to granted prots.
    flags: SecCtxFlags,               /// Flags specific to this security context.
}
```

=== Map
The map holds positions to Capabilities relevant to some target object, which
the relevant security context implementations for kernel and userspaces to
parse security context objects. Implicitly, the kernel uses
this map for lookup while the user interacts with this map to indicate the insertion, removal, or modification of
a capability.

=== Masks
Masks act as a restraint on the permissions this context can provide for some targeted object.
This allows for more expressive security policy, such as being able to quickly restrict
permissions for an object, without having to remove a capability, and recreating one with the
dersired restricted permissions. 

The global mask is quite similar to the masks mentioned above, except that it operates on
permissions granted by the security context as a whole rather than a mask per distinct object id.
// what now
//
=== Flags






// on disk storage for security contexts for efficient lookup


// what else is special about security contexts?


#load-bib(read("refs.bib"))
