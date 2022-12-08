BTree is thoroughly unit tested. This can be used with iOS, MacOS, WatchOS, or Server Side Swift.


Open the readme file, you cannot see the angle brackets on the GitHub website. There are angle brackets in the examples.


You need three files.


1.) BTree.swift

2.) BTreeNode.swift

3.) BTreeIterator.swift


=================================

=================================


Example Use 1:

```

let tree = BTree<Int>(order: 3)

tree.insert(1)

tree.insert(1)

tree.insert(2)

let countOf1 = tree.countElement(1)

let countOf2 = tree.countElement(2)



print("1 appears \(countOf1) times in the tree")

print("2 appears \(countOf2) times in the tree")

```

=================================

=================================


Example Use 2:

```

let tree = BTree<String>(order: 4)

tree.insert("britain")

tree.insert("france")

tree.insert("mexico")

tree.insert("greece")

tree.insert("spain")

tree.insert("germany")

tree.insert("zambia")

tree.insert("ireland")


let containsGermany1 = tree.contains("germany")

let containsBritain1 = tree.contains("britain")

let containsMexico1 = tree.contains("mexico")


tree.remove("germany")

tree.remove("britain")

tree.remove("greece")


let containsGermany2 = tree.contains("germany")

let containsBritain2 = tree.contains("britain")

let containsMexico2 = tree.contains("mexico")


print("contains germany \t[before: \(containsGermany1) after: \(containsGermany2)]")

print("contains britain \t[before: \(containsBritain1) after: \(containsBritain2)]")

print("contains mexico \t[before: \(containsMexico1) after: \(containsMexico2)]")

```

=================================

=================================


Unit tests are available.


BTreeTests.swift (~30 seconds)

BTreeTestsRigorous.swift (~30 Minutes)

BTreeTestsOverNight.swift (~ 6 Hours)


