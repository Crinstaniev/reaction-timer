import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter"

actor Service {

    public type Name = Text;
    public type Score = Nat;

    public type Record = (Name, Score);

    let records = HashMap.HashMap<Name, Score>(0, Text.equal, Text.hash);

    public func insert(name: Name, score: Score): async () {
        records.put(name, score);
    };

    public query func getAll() : async [Record] {
        return Iter.toArray<Record>(records.entries());
    };

    public query func find(name: Name) : async ?Score {
        records.get(name);
    };
}