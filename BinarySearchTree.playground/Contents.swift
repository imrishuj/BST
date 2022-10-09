import UIKit

public class TreeNode {
    
    public var val: Int
    public var left: TreeNode? = nil
    public var right: TreeNode? = nil
    
    public init(_ val: Int) {
        self.val = val
    }
}

class BinarySearchTree {
    
    var root: TreeNode? = nil
    var secondNode: TreeNode? = nil
    var count: Int  = 0
    
    func nodeCount(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        let left = self.nodeCount(root?.left)
        let right = self.nodeCount(root?.right)
        return left + right + 1
    }
    
    func leafNodeCount(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        let count: Int = self.leafNodeCount(root?.left) + self.leafNodeCount(root?.right)
        if root?.left == nil && root?.right == nil {
            return count + 1
        }
        return count
    }
    
    func internalNodeCount(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        let count: Int = self.leafNodeCount(root?.left) + self.leafNodeCount(root?.right)
        if root?.left != nil && root?.right != nil {
            return count + 1
        }
        return count
    }
    
    func height(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        let left = self.height(root?.left)
        let right = self.height(root?.right)
        return (left > right) ? left + 1 : right + 1
    }
    
    func preOrder(_ root: TreeNode?) {
        guard root != nil else { return }
        print(root?.val as Any, terminator: " ")
        self.preOrder(root?.left)
        self.preOrder(root?.right)
    }
    
    func inOrder(_ root: TreeNode?) {
        guard root != nil else { return }
        self.inOrder(root?.left)
        print(root?.val as Any, terminator: " ")
        self.inOrder(root?.right)
    }
    
    func postOrder(_ root: TreeNode?) {
        guard root != nil else { return }
        self.postOrder(root?.left)
        self.postOrder(root?.right)
        print(root?.val as Any, terminator: " ")
    }
    
    func search(_ root: TreeNode?, _ value: Int) -> Bool {
        guard root != nil else { return false }
        if value == root?.val {
            return true
        } else if value < root?.val ?? 0 {
            return  self.search(root?.left, value)
        } else {
            return self.search(root?.right, value)
        }
    }
    
    func insert(_ value: Int) {
        if self.root == nil {
            self.root = TreeNode(value)
        } else {
            var tempNode: TreeNode? = self.root
            let nodeToBeInsert = TreeNode(value)
            while (tempNode != nil) {
                if (tempNode?.val ?? 0 >= value) {
                    if (tempNode?.left == nil) {
                        tempNode?.left = nodeToBeInsert
                        return
                    } else {
                        tempNode = tempNode?.left
                    }
                }
                else {
                    if (tempNode?.right == nil) {
                        tempNode?.right = nodeToBeInsert
                        return
                    } else {
                        tempNode = tempNode?.right
                    }
                }
            }
        }
    }
    
    func insert(_ root: TreeNode? , _ value : Int) -> TreeNode? {
        if (root != nil) {
            if (root?.val ?? 0 >= value) {
                root?.left = self.insert(root?.left, value)
            } else {
                root?.right = self.insert(root?.right, value)
            }
            return root
        }
        else {
            return TreeNode(value)
        }
    }
    
    func addNode(_ data: Int)    {
        self.root = insert(self.root, data)
    }
    
    func min(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else { return nil }
        var tempNode: TreeNode? = self.root
        while(tempNode?.left != nil) {
            tempNode = tempNode?.left
        }
        return tempNode
    }
    
    func max(_ root: TreeNode?) -> TreeNode? {
        guard root != nil else { return nil }
        var tempNode: TreeNode? = self.root
        while(tempNode?.right != nil) {
            tempNode = tempNode?.right
        }
        return tempNode
    }
    
    func delete(_ root: TreeNode? , _ value : Int) -> TreeNode? {
        var root = root
        if root == nil {
            print("NOT FOUND")
        } else if value < root?.val ?? 0 {
            root?.left = self.delete(root?.left, value)
        } else if value > root?.val ?? 0 {
            root?.right = self.delete(root?.right, value)
        } else {
            if root?.left == nil && root?.right == nil {
                root = nil
            } else if root?.left == nil {
                var tempNode = root
                root = root?.right
                tempNode = nil
            } else if root?.right == nil {
                var tempNode = root
                root = root?.left
                tempNode = nil
            } else {
                var successParentNode = root
                var successNode = root?.right
                while(successNode?.left != nil) {
                    successParentNode = successNode
                    successNode = successNode?.left
                }
                if successParentNode?.val != root?.val {
                    successParentNode?.left = successNode?.right
                } else {
                    successParentNode?.right = successNode?.right
                }
                root?.val = successNode?.val ?? 0
                successNode = nil
            }
        }
        return root
    }
}



func createBinarySearchTree() {
    let bTree = BinarySearchTree()
    bTree.addNode(4)
    bTree.addNode(3)
    bTree.addNode(5)
    bTree.addNode(15)
    bTree.addNode(12)
    bTree.addNode(10)
    print("ELEMENT IS FOUND", bTree.search(bTree.root, 2))
    print("ELEMENT IS FOUND", bTree.search(bTree.root, 5))
    print("MAX", bTree.min(bTree.root) as Any)
    print("MIN", bTree.max(bTree.root) as Any)
    print("PREORDER TRAVERSAL", bTree.preOrder(bTree.root))
    print("INORDER TRAVERSAL", bTree.inOrder(bTree.root))
    print("POSTORDER TRAVERSAL", bTree.postOrder(bTree.root))
    print("DELETED NODE", bTree.delete(bTree.root, 5) as Any)
    print("PREORDER TRAVERSAL", bTree.preOrder(bTree.root))
    print("INORDER TRAVERSAL", bTree.inOrder(bTree.root))
    print("POSTORDER TRAVERSAL", bTree.postOrder(bTree.root))
    print("HEIGHT OF TREE", bTree.height(bTree.root))
    print("TOTAL NODES", bTree.nodeCount(bTree.root))
    print("TOTAL LEAF NODES", bTree.leafNodeCount(bTree.root))
    print("TOTAL INTERNAL NODES", bTree.internalNodeCount(bTree.root))
}

//createBinarySearchTree()

func constructTreeFromPre(preOrder: [Int]) -> TreeNode? {
    var count = 0
    return constructTreeFromPre(preOrder: preOrder, maxBound: Int.max, count: &count)
}

func constructTreeFromPre(preOrder: [Int], maxBound: Int, count: inout Int) -> TreeNode? {
    if count == preOrder.count || preOrder[count] > maxBound { return nil }
    let newNode = TreeNode(preOrder[count])
    count = count + 1
    newNode.left = constructTreeFromPre(preOrder: preOrder, maxBound: newNode.val, count: &count)
    newNode.right = constructTreeFromPre(preOrder: preOrder, maxBound: maxBound, count: &count)
    return newNode
}

let tree = constructTreeFromPre(preOrder: [8,5,1,7,10,12])



