INSERT INTO hosts (
    id,
    account,
    display_name,
    created_on,
    modified_on,
    facts,
    tags,
    canonical_facts,
    system_profile_facts,
    stale_timestamp,
    reporter)
VALUES (
    '{{.ID}}',
    '5',
    'test',
    '2017-01-01 00:00:00',
    '{{.ModifiedOn}}',
    '{"test1": "test1a"}',
    '{"test2": "test2a"}',
    '{"test3": "test3a", "test4": ["asdf", "jkl;"], "test5": {"a": {"1": "123"}}, "test6": [{"1": "23"}, {"2": {"3": "345"}}]}',
    '{"newkey": "newvalue", "arch": "x86-64", "cpu_flags": ["flag1", "flag2"], "yum_repos": [{"name": "repo1", "enabled": true, "base_ur    l": "http://rpms.redhat.com", "gpgcheck": true}], "is_marketplace": false, "number_of_cpus": 1,  "number_of_sockets": 2}',
    '2017-01-01 00:00:00',
    'me')