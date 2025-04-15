# Random find and replace stuff I often use

<details><summary>Add serde skip serializing if option is none</summary>

### search:
```regex
(\W+)([^\/]*):( *)Option<(.*)>,
```
### replace:
```regex
#[serde(skip_serializing_if = "Option::is_none")]
${1}${2}:${3}Option<${4}>,
```

</details>
