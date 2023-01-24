# Binary Search Tree

A Binary Search Tree made with Ruby.

Assignment for the Ruby course of <a href="https://www.theodinproject.com/" rel="nofollow">The Odin Project</a>.

Specifications and details for the assignment can be found <a href="https://www.theodinproject.com/lessons/ruby-binary-search-trees" rel="nofollow">here</a>.

## Features

Create a binary tree from an array of numbers

Search through the binary tree, delete, insert, find, level_order, inorder, preorder, postorder, height, depth, balanced?, rebalance.

## Information


The hardest part for me was understanding how to delete a node that has a node above and below it without completely losing the information about the node below.

I got the idea to copy the node below and place it at the location of the node i want to delete, this method ensures that if this node also has other nodes connected to it, we do not lose copy the number of the node below, but we copy all of the information the node contains and this includes the nodes following it and the number.

But we also have to choose the lowest number if there is two children to the node we want to delete.

If we have a tree of the array [ 1, 2, 3, 4, 5, 6, 7 ]

![image](https://user-images.githubusercontent.com/83082486/214180895-ce22a1ea-8bda-4f80-88af-ce0904e2b816.png)

Here we want to delete 3.

The program will first search the number 3 (we know it's on the right because 3 > 1, get the information about it's children, choose the lowest number between the two children, copy the child, place the copy at number 3 and delete then delete the duplicate.

And that's how we can safely delete any node, including the root.

## Contact

<a href="https://twitter.com/aleksandar_code" rel="nofollow">@aleksandar_code</a>


