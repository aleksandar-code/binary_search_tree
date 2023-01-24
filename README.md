# Binary Search Tree

A Binary Search Tree made with Ruby.

Assignment for the Ruby course of <a href="https://www.theodinproject.com/" rel="nofollow">The Odin Project</a>.

Specifications and details for the assignment can be found <a href="https://www.theodinproject.com/lessons/ruby-binary-search-trees" rel="nofollow">here</a>.

## Features

Create a binary tree from an array of numbers

Search through the binary tree, delete, insert, find, level_order, inorder, preorder, postorder, height, depth, balanced?, rebalance.

## Information

The hardest part for me was understanding how to delete a node that has a node above and below it without completely losing the information about the node below.

I got the idea to copy the node below so that replace it at the location of the node i want to delete, this method ensures that if this node also has other nodes connected to it, we do not lose copy the node below, but we copy all of the information the node contains and this includes the nodes following it and the number.

## Contact

<a href="https://twitter.com/aleksandar_code" rel="nofollow">@aleksandar_code</a>


