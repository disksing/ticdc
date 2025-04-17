USE `test`;

CREATE TABLE multi_data_type
(
    id                   INT AUTO_INCREMENT,
    t_tinyint            TINYINT,
    t_tinyint_unsigned   TINYINT UNSIGNED,
    t_smallint           SMALLINT,
    t_smallint_unsigned  SMALLINT UNSIGNED,
    t_mediumint          MEDIUMINT,
    t_mediumint_unsigned MEDIUMINT UNSIGNED,
    t_int                INT,
    t_int_unsigned       INT UNSIGNED,
    t_bigint             BIGINT,
    t_bigint_unsigned    BIGINT UNSIGNED,
    t_boolean            BOOLEAN,
    t_float              FLOAT(6, 2),
    t_double             DOUBLE(6, 2),
    t_decimal            DECIMAL(38, 19),
    t_char               CHAR,
    t_varchar            VARCHAR(10),
    c_binary             binary(16),
    c_varbinary          varbinary(16),
    t_tinytext           TINYTEXT,
    t_text               TEXT,
    t_mediumtext         MEDIUMTEXT,
    t_longtext           LONGTEXT,
    t_tinyblob           TINYBLOB,
    t_blob               BLOB,
    t_mediumblob         MEDIUMBLOB,
    t_longblob           LONGBLOB,
    t_date               DATE,
    t_datetime           DATETIME,
    t_timestamp          TIMESTAMP NULL,
    t_time               TIME,
--  FIXME: Currently canal-adapter does not handle year types correctly.
--  t_year               YEAR,
    t_enum               ENUM ('enum1', 'enum2', 'enum3'),
    t_set                SET ('a', 'b', 'c'),
--  FIXME: Currently there will be data inconsistencies.
--  t_bit                BIT(64),
    t_json               JSON,
    PRIMARY KEY (id)
);

-- make sure `nullable` can be handled by the mounter and mq encoding protocol
INSERT INTO multi_data_type() VALUES ();

INSERT INTO multi_data_type( t_tinyint, t_tinyint_unsigned, t_smallint, t_smallint_unsigned, t_mediumint
                           , t_mediumint_unsigned, t_int, t_int_unsigned, t_bigint, t_bigint_unsigned
                           , t_boolean, t_float, t_double, t_decimal
                           , t_char, t_varchar, c_binary, c_varbinary, t_tinytext, t_text, t_mediumtext, t_longtext
                           , t_tinyblob, t_blob, t_mediumblob, t_longblob
                           , t_date, t_datetime, t_timestamp, t_time
                           , t_enum
                           , t_set, t_json)
VALUES ( -1, 1, -129, 129, -65536, 65536, -16777216, 16777216, -2147483649, 2147483649
       , true, 123.456, 123.123, 123456789012.123456789012
       , '测', '测试', x'89504E470D0A1A0A', x'89504E470D0A1A0A', '测试tinytext', '测试text', '测试mediumtext', '测试longtext'
       , 'tinyblob', 'blob', 'mediumblob', 'longblob'
       , '1977-01-01', '9999-12-31 23:59:59', '19731230153000', '23:59:59'
       , 'enum2'
       , 'a,b', NULL);

INSERT INTO multi_data_type( t_tinyint, t_tinyint_unsigned, t_smallint, t_smallint_unsigned, t_mediumint
                           , t_mediumint_unsigned, t_int, t_int_unsigned, t_bigint, t_bigint_unsigned
                           , t_boolean, t_float, t_double, t_decimal
                           , t_char, t_varchar, c_binary, c_varbinary, t_tinytext, t_text, t_mediumtext, t_longtext
                           , t_tinyblob, t_blob, t_mediumblob, t_longblob
                           , t_date, t_datetime, t_timestamp, t_time
                           , t_enum
                           , t_set, t_json)
VALUES ( -2, 2, -130, 130, -65537, 65537, -16777217, 16777217, -2147483650, 2147483650
       , false, 123.4567, 123.1237, 123456789012.1234567890127
       , '2', '测试2', x'89504E470D0A1A0B', x'89504E470D0A1A0B', '测试2tinytext', '测试2text', '测试2mediumtext', '测试longtext'
       , 'tinyblob2', 'blob2', 'mediumblob2', 'longblob2'
       , '2021-01-01', '2021-12-31 23:59:59', '19731230153000', '22:59:59'
       , 'enum1'
       , 'a,b,c', '{
    "id": 1,
    "name": "hello"
  }');

UPDATE multi_data_type
SET t_boolean = false
WHERE id = 1;

DELETE
FROM multi_data_type
WHERE id = 2;

CREATE TABLE multi_charset (
	id INT,
	name varchar(128) CHARACTER SET gbk,
	country char(32) CHARACTER SET gbk,
	city varchar(64),
	description text CHARACTER SET gbk,
	image tinyblob,
	PRIMARY KEY (id)
) ENGINE = InnoDB CHARSET = utf8mb4;

INSERT INTO multi_charset
VALUES (1, '测试', "中国", "上海", "你好,世界"
	, 0xC4E3BAC3CAC0BDE7);

INSERT INTO multi_charset
VALUES (2, '部署', "美国", "纽约", "世界,你好"
	, 0xCAC0BDE7C4E3BAC3);

UPDATE multi_charset
SET name = '开发'
WHERE name = '测试';

DELETE FROM multi_charset
WHERE name = '部署'
	AND country = '美国'
	AND city = '纽约'
	AND description = '世界,你好';

CREATE TABLE test_ddl1
(
    id INT AUTO_INCREMENT,
    c1 INT,
    PRIMARY KEY (id)
);

CREATE TABLE test_ddl2
(
    id INT AUTO_INCREMENT,
    c1 INT,
    PRIMARY KEY (id)
);

RENAME TABLE test_ddl1 TO test_ddl;

ALTER TABLE test_ddl
    ADD INDEX test_add_index (c1);

DROP INDEX test_add_index ON test_ddl;

ALTER TABLE test_ddl
    ADD COLUMN c2 INT NOT NULL;

TRUNCATE TABLE test_ddl;

DROP TABLE test_ddl2;

CREATE TABLE test_ddl2
(
    id INT AUTO_INCREMENT,
    c1 INT,
    PRIMARY KEY (id)
);

CREATE TABLE test_ddl3 (
	id INT,
	名称 varchar(128),
	PRIMARY KEY (id)
) ENGINE = InnoDB;

ALTER TABLE test_ddl3
	ADD COLUMN 城市 char(32);

ALTER TABLE test_ddl3
	MODIFY COLUMN 城市 varchar(32);

ALTER TABLE test_ddl3
	DROP COLUMN 城市;

CREATE TABLE 表1 (
	id INT,
	name varchar(128),
	PRIMARY KEY (id)
) ENGINE = InnoDB;

RENAME TABLE 表1 TO 表2;

DROP TABLE 表2;

CREATE TABLE binary_columns
(
    id                   INT AUTO_INCREMENT,
    c_binary             binary(255),
    c_varbinary          varbinary(255),
    t_tinyblob           TINYBLOB,
    t_blob               BLOB,
    t_mediumblob         MEDIUMBLOB,
    t_longblob           LONGBLOB,
    PRIMARY KEY (id)
);

INSERT INTO binary_columns (c_binary, c_varbinary, t_tinyblob, t_blob, t_mediumblob, t_longblob)
VALUES (
    x'808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF'
);

INSERT INTO binary_columns (c_binary, c_varbinary, t_tinyblob, t_blob, t_mediumblob, t_longblob)
VALUES (
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF',
    x'000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F404142434445464748494A4B4C4D4E4F505152535455565758595A5B5C5D5E5F606162636465666768696A6B6C6D6E6F707172737475767778797A7B7C7D7E7F808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9FA0A1A2A3A4A5A6A7A8A9AAABACADAEAFB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBFC0C1C2C3C4C5C6C7C8C9CACBCCCDCECFD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDFE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEFF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF'
);
