#!/bin/bash

# === CONFIGURATION ===
VM_IP="35.224.238.42"         # Replace with your VM's external IP
VM_USER="ubuntu"
SSH_KEY="$HOME/.ssh/id_rsa"
INVENTORY_FILE="inventory.ini"
PLAYBOOK_FILE="vm-setup.yml"

# === 1. Check if Ansible is installed ===
if ! command -v ansible &> /dev/null
then
    echo "🛠️  Installing Ansible..."
    sudo apt update && sudo apt install -y ansible
else
    echo "✅ Ansible is already installed."
fi

# === 2. Check SSH access ===
echo "🔐 Checking SSH access to $VM_USER@$VM_IP..."
ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$VM_USER@$VM_IP" "echo '✅ SSH connection successful.'" || {
    echo "❌ SSH connection failed. Please check IP, SSH key, and firewall rules."
    exit 1
}

# === 3. Create inventory file ===
echo "📦 Writing inventory file..."
cat > "$INVENTORY_FILE" <<EOF
[ubuntu-vm]
$VM_IP ansible_user=$VM_USER ansible_ssh_private_key_file=$SSH_KEY
EOF

# === 4. Run the Ansible playbook ===
echo "🚀 Running Ansible playbook: $PLAYBOOK_FILE"
ansible-playbook -i "$INVENTORY_FILE" "$PLAYBOOK_FILE"

