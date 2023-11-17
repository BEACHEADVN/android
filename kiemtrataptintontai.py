import os
import sys

def check_file_exists(file_path, output_file):
    if os.path.exists(file_path):
        result = f"{file_path}"
    else:
        result = f"Tệp {file_path} không tồn tại."

    with open(output_file, 'w') as file:
        file.write(result)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Sử dụng: python kiemtrafiletontai.py <đường_dẫn_tệp> <tên_tệp_kết_quả>")
        sys.exit(1)

    file_path = sys.argv[1]
    output_file = sys.argv[2]
    check_file_exists(file_path, output_file)