# Random find and replace stuff I often use

<details><summary>Add serde skip serializing if option is none</summary>

> [!NOTE]
> I couldnt figure out how to avoid matching the field if it already has the serde avoid serializing thing
> so either just be careful when doing that or just remove all the serde stop serializing if option is none tags first

### search:
```regex
([^\/]*):( *)Option<(.*)>,
```
### replace:
```rust
#[serde(skip_serializing_if = "Option::is_none")]
${1}:${2}Option<${3}>,
```

</details>
