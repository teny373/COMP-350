class Room {
  constructor(width, height, depth) {
    this.width = width;
    this.height = height;
    this.depth = depth;

    // 保存所有障碍物的边界信息
    this.colliders = [];

    // Colors
    this.wallColor = color(200, 200, 200);
    this.tableColor = color(139, 69, 19);
    this.objectColor1 = color(0, 0, 255);
    this.objectColor2 = color(0, 255, 0);
  }

  // 用于添加 box 类型障碍物
  addBoxCollider({ x, y, z, w, h, d }, fillColor) {
    this.colliders.push({ x, y, z, w, h, d });

    push();
    translate(x, y, z);
    fill(fillColor);
    box(w, h, d);
    pop();
  }

  display() {
    push();
    noFill();
    stroke(255);

    // Room boundaries (边界框，仅用作参考)
    box(this.width, this.height, this.depth);

    // 墙体和障碍物
    this.addBoxCollider({
      x: this.width / 4,
      y: 0,
      z: -this.depth / 3,
      w: this.width / 2,
      h: this.height,
      d: 80
    }, color(0, 255, 0)); // 绿色墙

    this.addBoxCollider({
      x: this.width / 4,
      y: 0,
      z: this.depth / 6,
      w: this.width / 2,
      h: this.height,
      d: 80
    }, color(0, 0, 255)); // 蓝色墙1

    this.addBoxCollider({
      x: -this.width / 4,
      y: 0,
      z: -this.depth / 9,
      w: this.width / 2,
      h: this.height,
      d: 80
    }, color(0, 0, 255)); // 蓝色墙2

    // 左墙
    push();
    translate(-this.width / 2, 0, 0);
    rotateY(PI / 2);
    fill(this.wallColor);
    plane(this.depth, this.height);
    pop();

    // 右墙
    push();
    translate(this.width / 2, 0, 0);
    rotateY(PI / 2);
    fill(this.wallColor);
    plane(this.depth, this.height);
    pop();

    // 顶部
    push();
    translate(0, -this.height / 2, 0);
    rotateX(PI / 2);
    fill(this.wallColor);
    plane(this.width, this.depth);
    pop();

    // 后墙（透明可见 box）
    push();
    translate(0, 0, -this.depth / 2);
    fill(this.wallColor);
    plane(this.width, this.height);
    pop();

    pop();
  }
}
