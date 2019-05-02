import argparse
import jinja2
import os.path
import sys
import yaml

def parse_args(argv):
    p = argparse.ArgumentParser(argv, description='purpose: render a single jinja2 template')
    p.add_argument('input', help='filename of jinja2 template')
    p.add_argument('-o', '--out', dest='output', required=True, help='output filename')
    p.add_argument('-c', '--ctx', dest='context', required=True, help='filename of YAML context object')
    return p.parse_args()

def render(ctx_fn, in_fn, out_fn):
    with open(ctx_fn) as ctx_f:
        ctx = yaml.safe_load(ctx_f)

    in_fn = os.path.abspath(in_fn)
    in_path, in_leaf = os.path.split(in_fn)
    env = jinja2.Environment(
        loader = jinja2.FileSystemLoader([in_path])
    )
    t = env.get_template(in_leaf)

    content = t.render(ctx)

    out_dir = os.path.dirname(out_fn)
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
    with open(out_fn, 'w') as f_out:
        f_out.write(content)

def main():
    args = parse_args(sys.argv[1:])
    render(args.context, args.input, args.output)

if __name__ == '__main__':
    main()
