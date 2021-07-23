import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import D "mo:base/Debug";

actor Service {

    public type Name = Text;
    public type Score = Nat;

    stable var storage : [(Name, Score)] = [];

    // let records = HashMap.HashMap<Name, Score>(0, Text.equal, Text.hash);
    let records = HashMap.fromIter<Name, Score>(storage.vals(), 0, Text.equal, Text.hash);

    public func insert(name: Name, score: Score): async () {
        records.put(name, score);
    };

    public query func getAll() : async [(Name, Score)] {
        return Iter.toArray(records.entries());
    };

    public query func find(name: Name) : async ?Score {
        records.get(name);
    };

    public shared(msg) func getIdentity() : async Principal {
        return msg.caller;
    };

    system func preupgrade() {
        storage := Iter.toArray(records.entries());
    };

    system func postupgrade() {
        storage := [];
    };
}