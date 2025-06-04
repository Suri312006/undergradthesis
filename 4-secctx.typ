#import "template.typ": *

#mol-chapter("Security Contexts")

Security Contexts are objects that processes attach to in-order to inherit the
permissions inside the context. The contexts store capabilities, allowing for userspace
programs to add capabilities to contexts, and kernel space to efficiently search
through them to determie whether a process has the permissions to perform a memory access.

== Base

Since security contexts can be interacted with by the kernel and userspace, there needs to
be a consistent definition that both parties can adhere to, which we define. Objects in Twizzler
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
the relevant security context implementations for kernel and userspace to
parse security context objects. Implicitly, the kernel uses
this map for lookup while the user interacts with this map to indicate the insertion, removal, or modification of
a capability.

=== Masks
Masks act as a restraint on the permissions this context can provide for some targeted object.
This allows for more expressive security policy, such as being able to quickly restrict
permissions for an object, without having to remove a capability and recreating one with the
dersired restricted permissions. 

The global mask is quite similar to the masks mentioned above, except that it operates on
permissions granted by the security context as a whole rather than a mask per distinct object id.
// what now
//
=== Flags
Flags is a bitmap allowing for a Security Context to have different properties. Currently, there
is only one value, UNDETACHABLE, marking the security context as a jail of sorts, as
once a process attaches to it, it won't be able to detach. This acts as a way to
limit the transfer of information if a thread attaches to a sensitive object. Once a thread
attaches to such a context, it is forced to end its execution with the objects that context grants
permission to. We also plan to utilize these flags in future works, as described in 6.1.


== Enforcement

All enforcement happens inside the kernel, which has a seperate view into Security Contexts
than userspace. The kernel keeps track of all security contexts that threads in Twizzler
attach to, instantiating a cache inside each one. Additionally, a thread can attach
to multiple security contexts, but can only utilize the permissions granted by one unless
they switch @twizzler. To manage these threads, the kernel assigns a Security Context Manager,
which holds onto security context references that a thread has.

The enforcement of security policy in Twizzler happens on page fault when trying to access
a new object @twizzler. Upon fault, the kernel inspects the target object and identifies the
default permissnons of that object. Then the kernel checks if the currently active
security context for the accessing thread has either cached or capabilities that provide
permissions. If default permissions + the active context permissions arent enough to
permit the access, the kernel then checks each of the inactive contexts to see if they
have any relevant permissions. If there exists such permissions, then the kernel will
switch the active context of that process to the previously inactive context where the permission
was found. If it fails all of these, then the kernel terminates the process, citing inadequate
permissions. 

Since the security context can have a mask per object, while also having a global_mask to
the protections it can grant, the kernel also takes this into account while determining if
a process has the permissions for access.

The original Twizzler paper @twizzler, and the following security paper
go into more detail about the philosophy behind why enforcement works this way, such as the
performance benefits of letting programs access objects directly without kernel involvement, etc. 

#load-bib(read("refs.bib"))
