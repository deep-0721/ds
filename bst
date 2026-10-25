#include <stdio.h>
#include <stdlib.h>

struct Node
{
    int data;
    struct Node *left;
    struct Node *right;
};

struct Node *root=NULL;

struct Node* createNode(int value)
{
    struct Node *newnode;
    newnode=(struct Node*)malloc(sizeof(struct Node));
    newnode->data=value;
    newnode->left=NULL;
    newnode->right=NULL;
    return newnode;
}

struct Node* insert(struct Node *root,int value)
{
    if(root==NULL)
        return createNode(value);

    if(value<root->data)
        root->left=insert(root->left,value);
    else if(value>root->data)
        root->right=insert(root->right,value);

    return root;
}

struct Node* search(struct Node *root,int value)
{
    if(root==NULL||root->data==value)
        return root;

    if(value<root->data)
        return search(root->left,value);

    return search(root->right,value);
}

void inorder(struct Node *root)
{
    if(root!=NULL)
    {
        inorder(root->left);
        printf("%d ",root->data);
        inorder(root->right);
    }
}

void preorder(struct Node *root)
{
    if(root!=NULL)
    {
        printf("%d ",root->data);
        preorder(root->left);
        preorder(root->right);
    }
}

void postorder(struct Node *root)
{
    if(root!=NULL)
    {
        postorder(root->left);
        postorder(root->right);
        printf("%d ",root->data);
    }
}

struct Node* findMin(struct Node *root)
{
    while(root->left!=NULL)
        root=root->left;
    return root;
}

struct Node* deleteNode(struct Node *root,int value)
{
    if(root==NULL)
        return root;

    if(value<root->data)
        root->left=deleteNode(root->left,value);
    else if(value>root->data)
        root->right=deleteNode(root->right,value);
    else
    {
        if(root->left==NULL&&root->right==NULL)
        {
            free(root);
            return NULL;
        }

        if(root->left==NULL)
        {
            struct Node *temp=root->right;
            free(root);
            return temp;
        }

        if(root->right==NULL)
        {
            struct Node *temp=root->left;
            free(root);
            return temp;
        }

        struct Node *temp=findMin(root->right);
        root->data=temp->data;
        root->right=deleteNode(root->right,temp->data);
    }

    return root;
}

int main()
{
    root=insert(root,50);
    root=insert(root,30);
    root=insert(root,70);
    root=insert(root,20);
    root=insert(root,40);
    root=insert(root,60);
    root=insert(root,80);

    printf("Inorder Traversal: ");
    inorder(root);

    printf("\nPreorder Traversal: ");
    preorder(root);

    printf("\nPostorder Traversal: ");
    postorder(root);

    if(search(root,40)!=NULL)
        printf("\n40 found in BST.");
    else
        printf("\n40 not found in BST.");

    root=deleteNode(root,30);

    printf("\n\nAfter deleting 30:");
    printf("\nInorder Traversal: ");
    inorder(root);

    return 0;
}
