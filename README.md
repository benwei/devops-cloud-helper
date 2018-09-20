* enter scripts/external_ip.sh
  
* run external_ip.sh

  ```
  bash scripts/external_ip.sh
  ```

* edit .config

  ```
  group_id="aws security group id"
  group_name="aws security group name"
  desc_prefix="prefix of your rule's description"
  ip_proto=tcp   # tcp|udp
  from_port=22   # 1-65535
  to_port=22     # 1-65535
  ```

* run 
  ```
  bash aws/set_security_group_ingress_with_cidr_and_desc.sh "your_ip_address"
  ```
