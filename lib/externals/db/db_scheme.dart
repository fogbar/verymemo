final dbSchemes = [
  '''
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    displayName TEXT,
    photoUrl TEXT,
    provider TEXT NOT NULL,
    createdAt TEXT NOT NULL,
    lastSignInAt TEXT
  );
    ''',
  '''
CREATE TABLE IF NOT EXISTS images (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  memoId INTEGER NOT NULL,
  imageUrl TEXT NOT NULL,
  description TEXT,
  FOREIGN KEY (memoId) REFERENCES memos(id) ON DELETE CASCADE
);
''',
  '''
CREATE TABLE IF NOT EXISTS links (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  memoId INTEGER NOT NULL,
  url TEXT NOT NULL,
  thumbnail TEXT,
  metaTitle TEXT,
  metaDescription TEXT,
  FOREIGN KEY (memoId) REFERENCES memos(id) ON DELETE CASCADE
);
''',
  '''
CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  tagName TEXT NOT NULL UNIQUE
);
''',
  '''
CREATE TABLE IF NOT EXISTS memo_tags (
  memoId INTEGER NOT NULL,
  tagId INTEGER NOT NULL,
  PRIMARY KEY (memoId, tagId),
  FOREIGN KEY (memoId) REFERENCES memos(id) ON DELETE CASCADE,
  FOREIGN KEY (tagId) REFERENCES tags(id) ON DELETE CASCADE
);
''',
];

const tableName = <String>[
  'memos',
  'users',
  'images',
  'links',
  'tags',
  'memo_tags',
];
