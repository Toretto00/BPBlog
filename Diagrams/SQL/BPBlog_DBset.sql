CREATE DATABASE BPBlog

CREATE TABLE [post] (
    [id] INT NOT NULL ,
    [authorId] INT  NOT NULL ,
    [title] NVARCHAR(75) NOT NULL ,
    [metaTitle] NVARCHAR(100),
    [summary] NVARCHAR,
    [status] NVARCHAR,
    [createAt] DATETIME,
    [updateAt] DATETIME,
    [publishAt] DATETIME,
    [content] NTEXT,
    CONSTRAINT [PK_post] PRIMARY KEY CLUSTERED (
        [id] ASC
    )
)

CREATE TABLE [category] (
    [id] INT  NOT NULL ,
    [parentId] INT,
    [title] NVARCHAR(75)  NOT NULL ,
    CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED (
        [id] ASC
    )
)

CREATE TABLE [post_category] (
    [postId] INT  NOT NULL ,
    [categoryId] INT  NOT NULL 
)

CREATE TABLE [tag] (
    [id] INT  NOT NULL ,
    [title] NVARCHAR(75)  NOT NULL ,
    CONSTRAINT [PK_tag] PRIMARY KEY CLUSTERED (
        [id] ASC
    )
)

CREATE TABLE [post_tag] (
    [postId] INT  NOT NULL ,
    [tagId] INT  NOT NULL 
)

CREATE TABLE [post_comment] (
    [id] INT  NOT NULL ,
    [postId] INT  NOT NULL ,
    [authorId] INT  NOT NULL ,
    [parentId] INT,
    [title] NVARCHAR(100)  NOT NULL ,
    [createAt] DATETIME,
    [content] NTEXT  NOT NULL ,
    CONSTRAINT [PK_post_comment] PRIMARY KEY CLUSTERED (
        [id] ASC
    )
)

CREATE TABLE [user] (
    [id] INT  NOT NULL ,
    [firstName] NVARCHAR(50)  NOT NULL ,
    [lastName] NVARCHAR(50)  NOT NULL ,
    [phone] NVARCHAR(15)  NOT NULL ,
    [email] NVARCHAR(50)  NOT NULL ,
    [password] NVARCHAR(32)  NOT NULL ,
    [registerAt] DATETIME,
    [role] VARCHAR(15)  NOT NULL ,
    CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED (
        [id] ASC
    )
)

ALTER TABLE [post] WITH CHECK ADD CONSTRAINT [FK_post_authorId] FOREIGN KEY([authorId])
REFERENCES [user] ([id])

ALTER TABLE [post] CHECK CONSTRAINT [FK_post_authorId]

ALTER TABLE [post_category] WITH CHECK ADD CONSTRAINT [FK_post_category_postId] FOREIGN KEY([postId])
REFERENCES [post] ([id])

ALTER TABLE [post_category] CHECK CONSTRAINT [FK_post_category_postId]

ALTER TABLE [post_category] WITH CHECK ADD CONSTRAINT [FK_post_category_categoryId] FOREIGN KEY([categoryId])
REFERENCES [category] ([id])

ALTER TABLE [post_category] CHECK CONSTRAINT [FK_post_category_categoryId]

ALTER TABLE [post_tag] WITH CHECK ADD CONSTRAINT [FK_post_tag_postId] FOREIGN KEY([postId])
REFERENCES [post] ([id])

ALTER TABLE [post_tag] CHECK CONSTRAINT [FK_post_tag_postId]

ALTER TABLE [post_tag] WITH CHECK ADD CONSTRAINT [FK_post_tag_tagId] FOREIGN KEY([tagId])
REFERENCES [tag] ([id])

ALTER TABLE [post_tag] CHECK CONSTRAINT [FK_post_tag_tagId]

ALTER TABLE [post_comment] WITH CHECK ADD CONSTRAINT [FK_post_comment_postId] FOREIGN KEY([postId])
REFERENCES [post] ([id])

ALTER TABLE [post_comment] CHECK CONSTRAINT [FK_post_comment_postId]

ALTER TABLE [post_comment] WITH CHECK ADD CONSTRAINT [FK_post_comment_authorId] FOREIGN KEY([authorId])
REFERENCES [user] ([id])

ALTER TABLE [post_comment] CHECK CONSTRAINT [FK_post_comment_authorId]

ALTER TABLE post ALTER COLUMN summary NVARCHAR(50);
ALTER TABLE post ALTER COLUMN status NVARCHAR(10);

-- Insert sample data
-- Users
INSERT INTO [user] (id, firstName, lastName, phone, email, password, registerAt, role) VALUES
(1, N'John', N'Doe', N'1234567890', N'john.doe@example.com', N'password123', GETDATE(), N'admin'),
(2, N'Jane', N'Smith', N'0987654321', N'jane.smith@example.com', N'password456', GETDATE(), N'author');

-- Categories
INSERT INTO [category] (id, parentId, title) VALUES
(1, NULL, N'General'),
(2, 1, N'SubCategory of General');

-- Tags
INSERT INTO [tag] (id, title) VALUES
(1, N'Tutorial'),
(2, N'News');

-- Posts
INSERT INTO [post] (id, authorId, title, metaTitle, summary, status, createAt, updateAt, publishAt, content) VALUES
(1, 1, N'First Post', N'First Post Meta', N'This is the summary of the first post.', N'published', GETDATE(), GETDATE(), GETDATE(), N'This is the content of the first post.'),
(2, 2, N'Second Post', N'Second Post Meta', N'This is the summary of the second post.', N'draft', GETDATE(), GETDATE(), NULL, N'This is the content of the second post.');

-- Post Categories
INSERT INTO [post_category] (postId, categoryId) VALUES
(1, 1),
(2, 2);

-- Post Tags
INSERT INTO [post_tag] (postId, tagId) VALUES
(1, 1),
(2, 2);

-- Post Comments
INSERT INTO [post_comment] (id, postId, authorId, parentId, title, createAt, content) VALUES
(1, 1, 2, NULL, N'First Comment', GETDATE(), N'This is the first comment on the first post.'),
(2, 1, 1, 1, N'Reply to First Comment', GETDATE(), N'This is a reply to the first comment.');
