package com.example.demo.utils;



import java.util.ArrayList;
import java.util.List;

public class BST<T extends Comparable<T>> {
    private class Node {
        T data;
        Node left, right;

        Node(T data) {
            this.data = data;
            left = right = null;
        }
    }

    private Node root;

    public void insert(T data) {
        root = insertRec(root, data);
    }

    private Node insertRec(Node root, T data) {
        if (root == null) {
            return new Node(data);
        }
        if (data.compareTo(root.data) < 0) {
            root.left = insertRec(root.left, data);
        } else if (data.compareTo(root.data) > 0) {
            root.right = insertRec(root.right, data);
        }
        return root;
    }

    public T search(T data) {
        Node node = searchRec(root, data);
        return node != null ? node.data : null;
    }

    private Node searchRec(Node root, T data) {
        if (root == null || root.data.compareTo(data) == 0) {
            return root;
        }
        if (data.compareTo(root.data) < 0) {
            return searchRec(root.left, data);
        }
        return searchRec(root.right, data);
    }

    public void delete(T data) {
        root = deleteRec(root, data);
    }

    private Node deleteRec(Node root, T data) {
        if (root == null) {
            return null;
        }
        if (data.compareTo(root.data) < 0) {
            root.left = deleteRec(root.left, data);
        } else if (data.compareTo(root.data) > 0) {
            root.right = deleteRec(root.right, data);
        } else {
            if (root.left == null) {
                return root.right;
            } else if (root.right == null) {
                return root.left;
            }
            root.data = minValue(root.right);
            root.right = deleteRec(root.right, root.data);
        }
        return root;
    }
    public class BinarySearchTree<T extends Comparable<T>> {
        private class Node {
            T data;
            Node left, right;

            Node(T data) {
                this.data = data;
            }
        }

        private Node root;

        // In-order traversal to get all items sorted
        public List<T> getAll() {
            List<T> result = new ArrayList<>();
            inOrder(root, result);
            return result;
        }

        private void inOrder(Node node, List<T> list) {
            if (node != null) {
                inOrder(node.left, list);
                list.add(node.data);
                inOrder(node.right, list);
            }
        }

        // Add, remove, etc. could be here
    }


    private T minValue(Node root) {
        T minv = root.data;
        while (root.left != null) {
            minv = root.left.data;
            root = root.left;
        }
        return minv;
    }

    public List<T> getAll() {
        List<T> list = new ArrayList<>();
        inOrderRec(root, list);
        return list;
    }

    private void inOrderRec(Node root, List<T> list) {
        if (root != null) {
            inOrderRec(root.left, list);
            list.add(root.data);
            inOrderRec(root.right, list);
        }
    }
}